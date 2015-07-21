require 'spec_helper'

describe Transifex::Translation do
  include_context "shared stuff"

  it 'has content' do
    expect(translation.content).to eq(translation_data.content)
  end

  it 'has a resource' do
    expect(translation.resource).to eq(resource)
  end

  
end