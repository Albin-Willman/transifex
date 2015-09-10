require 'spec_helper'

describe Transifex::Config do
  it 'has a base URL' do
    expect(described_class::BASE_URL).to eq('https://www.transifex.com')
  end

  it 'has a user agent' do
    expect(described_class::USER_AGENT).to eq("transifex #{Transifex::VERSION}")
  end
end
