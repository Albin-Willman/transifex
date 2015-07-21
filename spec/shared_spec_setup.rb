RSpec.shared_context "shared stuff" do
  let(:account) { Transifex::Account.new('user', 'pwd') }
  let(:project_data) { Hashie::Mash.new(
    name: 'Example',
    description: 'desc',
    slug: 'example',
    source_language_code: 'en') }
  let(:project) { Transifex::Project.new(project_data, account) }

  let(:resources) { [resource_data] }
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
end
