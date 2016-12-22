require 'spec_helper'

describe YxSdk do
  it 'has a version number' do
    expect(YxSdk::VERSION).not_to be nil
  end

  it "test" do
    expect(YxSdk::Foo.new()).not_to be nil
  end

  it 'can be init' do
    expect(YxSdk::Client.new('a', 'b')).not_to be nil  
  end
end
