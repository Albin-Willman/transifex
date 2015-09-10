RSpec.shared_context "shared stuff" do
  let(:client) { Transifex::Client.new('user', 'pwd') }
  let(:project_data) { Hashie::Mash.new(
    name: 'Example',
    description: 'desc',
    slug: 'example',
    source_language_code: 'en') }
  let(:project)  { Transifex::Project.new(project_data, client) }
  let(:projects) { [project_data] }

  let(:resources) { [resource_data] }
  let(:resource_data) {
    Hashie::Mash.new(
      name: 'Example',
      categories: 'cat',
      i18n_type: 'YML',
      priority: "0",
      slug: 'example',
      source_language_code: 'en'
      )
  }
  let(:resource) { Transifex::Resource.new(resource_data, project) }
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
  let(:translation) { Transifex::Translation.new(translation_data, resource) }

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

  def data_to_projects(data, a)
    data.map { |project_data| Transifex::Project.new(project_data, a) }
  end

  def compare_projects(res, expected)
    expect(res.name).to eq(expected.name)
    expect(res.slug).to eq(expected.slug)
    expect(res.description).to eq(expected.description)
    expect(res.main_language).to eq(expected.main_language)
    expect(res.client).to eq(expected.client)
  end
end
