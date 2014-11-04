require 'thrifty_bunny'
require_relative 'calculator_service'

module Calculator

  class Client < CalculatorService::Client

    # def initialize(options={})
    #   @transport = ThriftyBunny::ClientTransport.new
    #   protocol = Thrift::BinaryProtocol.new(@transport)
    #   @client = CalculatorService::Client.new(protocol)
    # end

    # def say_hello(name)
    #   safe_transport do
    #     @client.say_hello(name)
    #   end
    # end

    # private

    # def safe_transport
    #   begin
    #     @transport.open
    #     return yield
    #   rescue ThriftyBunny::ResponseTimeout => e
    #     puts e
    #   ensure
    #     @transport.close
    #   end
    # end

    # def send_message(name, args_class, args = {})
    #   @oprot.write_message_begin(name, Thrift::MessageTypes::CALL, @seqid)
    #   data = args_class.new
    #   fld = 1

    #   args.each do |k, v|
          
    #     if data.struct_fields[fld][:type] == Thrift::Types::STRUCT and data.struct_fields[fld][:class] == JsonData
    #       res = Json_data.new()
    #       res.data = JSON.generate(v)
    #       v = res
    #     end
          
    #     data.send("#{k.to_s}=", v)
    #     fld += 1
    #   end
    #   begin
    #     data.write(@oprot)
    #   rescue StandardError => e
    #     @oprot.trans.close
    #     raise e
    #   end
    #   @oprot.write_message_end

    #   #If the oneway modifier is used in the thrift definition, then the recv_ version of the methods will
    #   #not be generated, so if it does not exist then no need to wait for a response.
    #   blocking_call = self.respond_to?("recv_" + name)

    #   @oprot.trans.flush(:operation => name,
    #                      :blocking => blocking_call,
    #                      :log_messages => true)

    # end

    # def receive_message(result_klass)
    #   fname, mtype, rseqid = @iprot.read_message_begin
    #   handle_exception(mtype)
    #   result = result_klass.new
    #   result.read(@iprot)
    #   @iprot.read_message_end

    #   if result.respond_to?(:success) and result.success.class == JsonData and
    #       result.struct_fields[0][:type] == Thrift::Types::STRUCT and result.struct_fields[0][:class] == JsonData
    #     json_res = JSON.parse(result.success.data)

    #     result.success = json_res
    #   end

    #   result

    # end


  end

end

# client = HelloThrift::Client.new

# loop do
#   print "What is your name? "
#   input = gets.strip
#   break if input == 'quit'
#   puts client.say_hello(input)
# end