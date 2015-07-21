require 'spec_helper'

describe Transifex::Translation do
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
  let(:resource) { Transifex::Resource.new(resource_data, project) }
  let(:translation_data) {
    Hashie::Mash.new(content: 'en:
      test:
        test: "data"')
  }
  let(:translation) { Transifex::Translation.new(translation_data, resource) }

  it 'has content' do
    expect(translation.content).to eq(translation_data.content)
  end

  it 'has a resource' do
    expect(translation.resource).to eq(resource)
  end

  
end