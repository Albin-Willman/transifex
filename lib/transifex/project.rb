module Transifex
  class Project
    attr_accessor :name, :description, :slug, :main_language, :account
    def initialize(project_data, account)
      @name          = project_data.name
      @description   = project_data.description
      @slug          = project_data.slug
      @main_language = project_data.source_language_code
      @account       = account
    end

    def resources
       account.get("/project/#{slug}/resources/")
    end

    def resource(resource_slug)
       account.get("/project/#{slug}/resource/#{resource_slug}/")
    end
  end
end