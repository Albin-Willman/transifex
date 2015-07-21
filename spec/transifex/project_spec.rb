require 'spec_helper'

describe Transifex::Project do
  let(:account) { Transifex::Account.new('user', 'pwd') }
  let(:project_data) { Hashie::Mash.new(
    name: 'Example',
    description: 'desc',
    slug: 'example',
    source_language_code: 'en') }
  let(:project) { described_class.new(project_data, account) }

  let(:resources) { [resource] }
  let(:resource) {
    Hashie::Mash.new(
      name: 'Example',
      categories: 'cat',
      type: 'YML',
      priority: "0",
      slug: 'example',
      source_language_code: 'en'
      )
  }

  let(:language_data) {
    [
      Hashie::Mash.new(language_code: 'en'),
      Hashie::Mash.new(language_code: 'se')
    ]
  }
  let(:translation_data) {
    Hashie::Mash.new(content: 'en:
      test:
        test: "data"')
  }

  def data_to_resources(data, p)
    data.map { |resource_data| Transifex::Resource.new(resource_data, p) }
  end

  def compare_resources(res, expected)
    expect(res.name).to eq(expected.name)
    expect(res.slug).to eq(expected.slug)
    expect(res.type).to eq(expected.type)
    expect(res.main_language).to eq(expected.main_language)
    expect(res.project).to eq(expected.project)
  end
  
  it 'has a name' do
    expect(project.name).to eq('Example')
  end

  it 'has a description' do
    expect(project.description).to eq('desc')
  end

  it 'has a slug' do
    expect(project.slug).to eq('example')
  end

  it 'has a main_language' do
    expect(project.main_language).to eq('en')
  end

  it 'can retrive a resource list' do
    allow(account).to receive(:get).and_return('Not Found')
    allow(account).to receive(:get).with('/project/example/resources/').and_return(resources)
    expected = data_to_resources(resources, project)
    res = project.resources
    expect(res.length).to eq(expected.length)
    res.each_with_index do |res_resource, i|
      expected_resource = expected[i]
      compare_resources(res_resource, expected_resource)
    end
  end

  it 'can retrive languages' do
    allow(account).to receive(:get).with('/project/example/languages/').and_return(language_data)
    expect(project.languages).to eq(['en', 'se'])
  end

  context 'resource' do
    it 'can retrive a specific resource' do
      allow(account).to receive(:get).with('/project/example/resource/example/').and_return(resource)
      res = project.resource('example')
      expected = Transifex::Resource.new(resource, project)
      compare_resources(res, expected)
    end

    it 'returns not found if no record is found' do
      allow(account).to receive(:get).with('/project/example/resource/non-existing/').and_return('Not Found')
      expect(project.resource('non-existing')).to be_nil
    end
  end

  context 'translation' do
    it 'can retrive a translation' do
      allow(account).to receive(:get).with('/project/example/resource/example/translation/en/').and_return(translation_data)
      expected = Transifex::Translation.new(translation_data, resource)
      res      = project.translation(resource, 'en')
      expect(expected.content).to  eq(res.content)
      expect(expected.resource).to eq(res.resource)
    end
  end
end