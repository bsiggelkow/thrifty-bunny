require 'thrift'

module ThriftyBunny

  class RpcServer < ::Thrift::BaseServer

    class ProcessingTimeout < Timeout::Error; end

    def initialize(processor, config=Config.new, options={})

      @processor = processor

      if options[:connection].nil?
        @conn = Bunny.new(config.bunny_config)
        @conn.start
      else
        @conn = options[:connection]
      end

      @queue_name = config.queue
      @protocol_factory = options[:protocol_factory] || Thrift::BinaryProtocolFactory
      @exchange = config.exchange

    end

    def close

      if not @request_channel.nil? and @request_channel.respond_to?('close')
        @request_channel.close
      end

      #Always close the broker connection when closing the server
      @conn.close

    end

    def serve(options={})
      log_messages = options[:log_messages] || false
      max_messages = options[:max_messages].nil? ? 10 : options[:max_messages]
      response_timeout = options[:response_timeout] || 10

      #Create a channel to the service queue
      @request_channel = @conn.create_channel(nil, max_messages )

      if @exchange.nil?
        @service_exchange = @request_channel.default_exchange
        @request_queue = @request_channel.queue(@queue_name, :auto_delete => true)
      else
        @service_exchange = @request_channel.direct(@exchange,:durable => true)
        @request_queue = @request_channel.queue(@queue_name, :auto_delete => true).bind(@service_exchange, :routing_key => @queue_name)
      end

      @request_queue.subscribe(:block => true) do |delivery_info, properties, payload|

        if log_messages
          Thread.current["correlation_id"] = properties.correlation_id
          print_log "---- Message received ----"
          print_log "HEADERS: #{properties}"
        end

        Thread.current["correlation_id"] = properties.correlation_id

        response_channel = @conn.create_channel
        response_exchange = response_channel.default_exchange

        response_required = properties.headers.has_key?('response_required') ? properties.headers['response_required'] : true
        process_timeout = response_timeout.to_i > properties.expiration.to_i ? response_timeout.to_i : properties.expiration.to_i

        #Binary content will imply thrift based message payload
        if properties.content_type == 'application/octet-stream'

          print_log "Request to process #{@queue_name}.#{properties.headers['operation']} in #{process_timeout}sec" if log_messages

          input = StringIO.new payload
          out = StringIO.new
          transport = Thrift::IOStreamTransport.new input, out
          protocol = @protocol_factory.new.get_protocol transport

          begin
            start_time = Time.now
            Timeout.timeout(process_timeout, ProcessingTimeout) do
              @processor.process protocol, protocol
            end
            processing_time = Time.now - start_time

            #rewind the buffer for reading
            if out.length > 0
              out.rewind

              print_log "Time to process request: #{processing_time}sec  Response length: #{out.length}"   if log_messages

              if response_required
                response_exchange.publish(out.read(out.length),
                                          :routing_key => properties.reply_to,
                                          :correlation_id => properties.correlation_id,
                                          :content_type => 'application/octet-stream' )
              end
            end

          rescue ProcessingTimeout => ex
            print_log "A timeout has occurred (#{process_timeout}sec) trying to call #{@queue_name}.#{properties.headers['operation']}"
          end

        else

          print_log "Unable to process message content of type #{properties.content_type}. The message will be rejected"
          @request_channel.reject(delivery_info.delivery_tag, false)

        end

        response_channel.close


      end
    end

    private

    def print_log(message="")
      puts "#{Time.now.utc} S Thread: #{Thread.current.object_id} CID:#{Thread.current["correlation_id"]} - #{message}"
    end

  end

end
