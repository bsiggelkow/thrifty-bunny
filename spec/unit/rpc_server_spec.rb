require 'spec_helper'

describe 'RpcServer' do
  let(:server) { ThriftyBunny::RpcServer.new(nil, ThriftyBunny::Config.new) }
  it 'initializes' do
    expect(server).to_not be_nil
  end
end