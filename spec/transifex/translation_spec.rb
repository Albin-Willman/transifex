require 'spec_helper'

describe Transifex::Translation do
  include_context "shared stuff"

  it 'has content' do
    expect(translation.content).to eq(translation_data.content)
  end

  it 'has a resource' do
    expect(translation.resource).to eq(resource)
  end

  it 'can convert the content to a hash' do
    res = translation.content_hash
    expect(res).to eq({ "en" => { 'test' => { 'test' => 'data' } } })
  end
end