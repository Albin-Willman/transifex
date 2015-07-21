require 'spec_helper'

describe Transifex::Project do

  let(:input_data) { Hashie::Mash.new(
    name: 'Example',
    description: 'desc',
    slug: 'example',
    source_language_code: 'en') }
  let(:res) { described_class.new(input_data, account) }

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
  let(:account) { Transifex::Account.new('user', 'pwd') }



  it 'has a name' do
    expect(res.name).to eq('Example')
  end

  it 'has a description' do
    expect(res.description).to eq('desc')
  end

  it 'has a slug' do
    expect(res.slug).to eq('example')
  end

  it 'has a main_language' do
    expect(res.main_language).to eq('en')
  end

  it 'can retrive a resource list' do
    allow(account).to receive(:get).and_return(:test)
    allow(account).to receive(:get).with('/project/example/resources/').and_return(resources)
    expect(res.resources).to eq(resources)
  end

  context 'resource' do
    it 'can retrive a specific resource' do
      allow(account).to receive(:get).with('/project/example/resource/example/').and_return(resource)
      expect(res.resource('example')).to eq(resource)
    end

    it 'returns not found if no record is found' do
      allow(account).to receive(:get).with('/project/example/resource/non-existing/').and_return('Not Found')
      expect(res.resource('non-existing')).to eq('Not Found')
    end
  end    
end