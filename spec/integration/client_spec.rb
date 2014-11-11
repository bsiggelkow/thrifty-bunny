require 'spec_helper'
require 'calculator_service'
require 'calculator_server'

describe 'client calls service' do

  # Run the server in a forked sub-process
  def launch_server
    pid = fork do
      puts "Starting server ..."
      server = Calculator::Server.new
      server.serve
    end
  end

  before(:each) do
    launch_server
    transport = ThriftyBunny::ClientTransport.new
    protocol = Thrift::BinaryProtocol.new(transport)
    @client = CalculatorService::Client.new(protocol)
  end

  it 'works' do
    res = @client.say_hello('Bob')
    expect(res).to eq("Hello, Bob from Thrift!")
  end

end
