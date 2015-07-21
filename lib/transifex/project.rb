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
       @resources ||= initializ_resources(account.get("#{base_path}/resources/"))
    end

    def resource(resource_slug)
      resource_data = account.get(resource_path(resource_slug))
      return if resource_data == 'Not Found'
      Resource.new(resource_data, self)
    end

    def languages
      @languages ||= account.get("#{base_path}/languages/").map(&:language_code)
    end

    def translation(resource, language_code)
      Translation.new(account.get("#{resource_path(resource.slug)}translation/#{language_code}/"), resource)
    end

    private

    def resource_path(resource_slug)
      "#{base_path}/resource/#{resource_slug}/"
    end

    def base_path
      "/project/#{slug}"
    end

    def initializ_resources(resource_data_array)
      resource_data_array.map do |resource_data|
        Resource.new(resource_data, self)
      end
    end
  end
end