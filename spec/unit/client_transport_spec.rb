require 'spec_helper'

describe 'ClientTransport' do
  it 'initializes' do
    transport = ThriftyBunny::ClientTransport.new('my_queue')
    transport.should_not be_nil
  end
end