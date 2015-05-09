require 'spec_helper'
require 'calculator_service'
require 'calculator_server'

describe 'client calls service to' do

  # Run the server in a forked sub-process
  def launch_server
    @pid = fork do
      Signal.trap("HUP") { puts "Stopping server as planned."; exit }
      puts "Starting server as planned."
      server = Calculator::Server.new(timeout: 5)
      server.serve
    end
  end

  before(:all) do
    launch_server
  end

  after(:all) do
    Process.kill("HUP", @pid)
  end

  def start_client
    config = ThriftyBunny::Config.new(timeout: 10)
    @transport = ThriftyBunny::ClientTransport.new(config)
    protocol = Thrift::BinaryProtocol.new(@transport)
    @client = CalculatorService::Client.new(protocol)
  end

  before do
    start_client
  end

  after do
    @transport.close
  end

  it 'request ping' do
    expect {
      @client.ping
    }.to_not raise_error
  end

  it 'say hello' do
    res = @client.say_hello('Bob')
    expect(res).to eq("Hello, Bob from Thrift!")
  end

  it 'successfully divide 10 by 5' do
    res = @client.divide(10, 5)
    expect(res).to eq(2.0)
  end

  it 'throw a divide by zero exception' do
    expect {
      res = @client.divide(10, 0)
    }.to raise_error(DivideByZeroException)
  end

  it 'successfully calculates age' do
    res = @client.age(10, 65)
    puts res
    expect(res).to eq(55)
  end

  it 'receives a response timeout' do
    # snooze for one second longer than timeout
    expect {
      @client.snooze(11)
    }.to raise_error(ThriftyBunny::ResponseTimeout)
  end

end
