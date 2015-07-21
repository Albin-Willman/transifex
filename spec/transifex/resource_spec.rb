require 'spec_helper'

describe Transifex::Resource do
  include_context "shared stuff"

  it 'has a name' do
    expect(resource.name).to eq('Example')
  end

  it 'has a type' do
    expect(resource.type).to eq('YML')
  end

  it 'has a slug' do
    expect(resource.slug).to eq('example')
  end

  it 'has a main_language' do
    expect(resource.main_language).to eq('en')
  end

  it 'has a project' do
    expect(resource.project).to eq(project)
  end

end