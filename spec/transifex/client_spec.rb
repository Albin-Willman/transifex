require 'spec_helper'

describe Transifex::Client do
  include_context "shared stuff"

  context 'connection' do
    it 'has a faraday connection' do
      expect(client.connection.is_a?(Faraday::Connection)).to be_truthy
    end

    it 'has a correct header' do
      res = client.connection.headers
      expect(res['Accept']).to eq('application/json')
      expect(res['User-Agent']).to eq("transifex #{Transifex::VERSION}")
      expect(res['Authorization']).to include('Basic')
    end

    it 'has correct url set' do
      expect(client.connection.url_prefix.host).to eq('www.transifex.com')
    end
  end

  context 'projects' do
    it 'can retrieve a list of projects' do
      allow(client).to receive(:get).and_return('BAD REQUEST')
      allow(client).to receive(:get).with('/projects/').and_return(projects)
      expected = data_to_projects(projects, client)
      res = client.projects
      res.each_with_index do |res_project, i|
        compare_projects(res_project, expected[i])
      end
    end

    it 'can retrive a specific resource' do
      allow(client).to receive(:get).with('/project/example/').and_return(project_data)
      res = client.project('example')
      expected = Transifex::Project.new(project_data, client)
      compare_projects(res, expected)
    end

    it 'can retrive a specific resource' do
      allow(client).to receive(:get).with('/project/non-existing/').and_return('Not Found')
      expect(client.project('non-existing')).to be_nil
    end
  end

  it 'calls uses the faraday connection on get' do
    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(OpenStruct.new(body: 'body'))
    expect(client.get('test')).to eq('body')
  end
end
