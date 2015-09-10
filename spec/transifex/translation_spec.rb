require 'spec_helper'

describe Transifex::Translation do
  include_context 'shared stuff'

  it 'has a resource' do
    expect(translation.resource).to eq(resource)
  end

  it 'can convert the content to a hash' do
    res = translation.content
    expect(res).to eq({ 'en' => { 'test' => { 'test' => 'data' } } })
  end

  it 'raises an error when resource has unkown content type' do
    fake_type     = 'unknown_content_type'
    fake_resource = OpenStruct.new(type: fake_type)
    fake_content  = OpenStruct.new
    expect do
      described_class.new(fake_content, fake_resource).content
    end.to raise_error(Transifex::UnkownContentTypeError, "Unrecognized content type: #{fake_type}")
  end

  it 'raises an error if it does not recognize the type' do
    resource.instance_variable_set('@type', 'invalid')
    expect { translation.content }.to raise_error('Unrecognized content type: invalid')
  end
end
