require 'thrifty_bunny'
require_relative 'hello_service/hello_service'

module HelloThrift

  class Client    

    def initialize(options={})
      @transport = ThriftyBunny::ClientTransport.new
      protocol = Thrift::BinaryProtocol.new(@transport)
      @client = HelloService::Client.new(protocol)
    end

    def say_hello(name)
      safe_transport do
        @client.say_hello(name)
      end
    end

    private

    def safe_transport
      begin
        @transport.open
        return yield
      ensure
        @transport.close
      end
    end

  end

end

# client = HelloThrift::Client.new

# loop do
#   print "What is your name? "
#   input = gets.strip
#   break if input == 'quit'
#   puts client.say_hello(input)
# end