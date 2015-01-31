require 'thrifty_bunny'
require_relative 'calculator_service'

module Calculator

  class Handler
    def say_hello(name)
      "Hello, #{name} from Thrift!"
    end

    def add(value1, value2)
      value1 + value2
    end

    def divide(dividend, divisor)
      raise DivideByZeroException.new("Oops -- you tried to divide by zero; does not work in this universe.") if divisor == 0
      dividend.to_f /  divisor.to_f
    end

    def ping
    end
  end

  class Server
    attr_reader :service

    def initialize(options={})
      handler = Handler.new
      processor = CalculatorService::Processor.new(handler)
      @service = ThriftyBunny::RpcServer.new(processor)
    end

    def serve
      service.serve(log_messages: false, prefetch: 2)
    end
  end

end
