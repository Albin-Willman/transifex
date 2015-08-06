require 'spec_helper'

describe Transifex::Project do
  include_context "shared stuff"

  it 'has a name' do
    expect(project.name).to eq('Example')
  end

  it 'has a description' do
    expect(project.description).to eq('desc')
  end

  it 'has a main_language' do
    expect(project.main_language).to eq('en')
  end

  it 'can retrive a resource list' do
    allow(client).to receive(:get).and_return('BAD REQUEST')
    allow(client).to receive(:get).with('/project/example/resources/').and_return(resources)
    expected = data_to_resources(resources, project)
    res = project.resources
    expect(res.length).to eq(expected.length)
    res.each_with_index do |res_resource, i|
      compare_resources(res_resource, expected[i])
    end
  end

  it 'can retrive languages' do
    allow(client).to receive(:get).with('/project/example/languages/').and_return(language_data)
    expect(project.languages).to eq(['en', 'se'])
  end

  context 'resource' do
    it 'can retrive a specific resource' do
      allow(client).to receive(:get).with('/project/example/resource/example/').and_return(resource_data)
      res = project.resource('example')
      expected = Transifex::Resource.new(resource_data, project)
      compare_resources(res, expected)
    end

    it 'returns nil if no record is found' do
      allow(client).to receive(:get).with('/project/example/resource/non-existing/').and_return('Not Found')
      expect(project.resource('non-existing')).to be_nil
    end
  end

  context 'translation' do
    it 'can retrive a translation' do
      allow(client).to receive(:get).with('/project/example/resource/example/translation/en/').and_return(translation_data)
      expected = Transifex::Translation.new(translation_data, resource)
      res      = project.translation(resource, 'en')
      expect(expected.content).to  eq(res.content)
      expect(expected.resource).to eq(res.resource)
    end

    it 'returns nil if no record is found' do
      allow(client).to receive(:get).with('/project/example/resource/example/translation/non-existing/').and_return('Not Found')
      expect(project.translation(resource, 'non-existing')).to be_nil
    end
  end
end
