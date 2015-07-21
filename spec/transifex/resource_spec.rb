require 'spec_helper'

describe Transifex::Resource do
  let(:account) { Transifex::Account.new('user', 'pwd') }
  let(:project_data) { Hashie::Mash.new(
    name: 'Example',
    description: 'desc',
    slug: 'example',
    source_language_code: 'en') }
  let(:project) { Transifex::Project.new(project_data, account) }

  let(:resource_data) {
    Hashie::Mash.new(
      name: 'Example',
      categories: 'cat',
      type: 'YML',
      priority: "0",
      slug: 'example',
      source_language_code: 'en'
      )
  }
  let(:resource) { described_class.new(resource_data, project) }

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