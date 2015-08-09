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

  it 'raises an error if it does not recognize the type' do
    resource.instance_variable_set('@type', 'invalid')
    expect { translation.content }.to raise_error('Unrecognized content type: invalid')
  end
end
