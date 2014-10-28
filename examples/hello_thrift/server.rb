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
      @service = ThriftyBunny::RpcServer.new(processor)
    end

    def serve
      service.serve
    end
  end

end