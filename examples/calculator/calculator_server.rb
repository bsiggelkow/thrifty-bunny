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

    def dwarves
      %w(sneezy dopey doc)
    end

    def my_pets
      [ 
        Pet.new(kind: 'cat', name: 'Winston'), 
        Pet.new(kind: 'dog', name: 'Eve')
      ]
    end

    def age(age_min, age_max)
      age_max - age_min
    end

    def snooze(sleep_time)
      sleep sleep_time
    end

  end

  class Server
    attr_reader :service

    def initialize(options={})
      config = ThriftyBunny::Config.new(options)
      handler = Handler.new
      processor = CalculatorService::Processor.new(handler)
      @service = ThriftyBunny::RpcServer.new(processor, config)
    end

    def serve
      service.serve(prefetch: 2)
    end
  end

end
