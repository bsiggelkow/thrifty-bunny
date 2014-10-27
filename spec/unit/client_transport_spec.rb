require 'spec_helper'

describe 'ClientTransport' do
  it 'initializes' do
    transport = ThriftyBunny::ClientTransport.new(ThriftyBunny::Config.new)
    expect(transport).to_not be_nil
  end
end