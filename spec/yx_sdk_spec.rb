require 'spec_helper'

describe YxSdk do
  it 'has a version number' do
    expect(YxSdk::VERSION).not_to be nil
  end

  it 'can be init' do
    expect(YxSdk::Client.new('53f9279bbc91974bc306b35b0cf8fcbf', '932440ff0b8d')).not_to be nil  
  end

  # it 'can be register' do
  #   client = YxSdk::Client.new('53f9279bbc91974bc306b35b0cf8fcbf', '932440ff0b8d')
  #   params = {
  #         :accid => 'oM_Ocwlw4oJ9io6CWDpQawo_t-Q0',
  #         :name => 'eoeoeo'
  #     }
  #   result = client.create params
  #   expect(result.code).to be 200
  # end

  it 'can be refresh' do
    client = YxSdk::Client.new('53f9279bbc91974bc306b35b0cf8fcbf', '932440ff0b8d')
    result = client.refreshToken 'oM_Ocwlw4oJ9io6CWDpQawo_t-Q0'
    puts result
    expect(result.code).to be 200
  end
end
