require 'spec_helper'

describe 'RpcServer' do
  it 'initializes' do
    server = ThriftyBunny::RpcServer.new(nil)
    server.should_not be_nil
  end
end