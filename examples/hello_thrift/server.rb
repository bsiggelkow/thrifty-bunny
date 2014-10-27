require 'thrifty_bunny'
require_relative 'hello_service/hello_service'

module HelloThrift

  class Handler
    def say_hello(name)
      puts "Saying hello to #{name}"
      "Hello, #{name} from Thrift!"
    end
  end

  class Server
    attr_reader :service

    def initialize(options={})
      handler = Handler.new
      processor = HelloService::Processor.new(handler)
      # transport = Thrift::ServerSocket.new(port)
      # transportFactory = Thrift::BufferedTransportFactory.new
      @service = ThriftyBunny::RpcServer.new(processor)
      # @service = Thrift::SimpleServer.new(processor, transport, transportFactory)
    end

    def serve
      service.serve(log_messages:true)
    end
  end

end