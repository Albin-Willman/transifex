module Transifex
  # Holds data for a Transifex project
  class Project
    attr_accessor :name, :description, :slug, :main_language, :client

    def initialize(project_data, client)
      @name          = project_data.name
      @description   = project_data.description
      @slug          = project_data.slug
      @main_language = project_data.source_language_code
      @client        = client
    end

    def resources
       @resources ||= initialize_resources(client.get("#{base_path}/resources/"))
    end

    def resource(resource_slug)
      resource_data = client.get(resource_path(resource_slug))
      return if resource_data == 'Not Found'
      Resource.new(resource_data, self)
    end

    def languages
      @languages ||= client.get("#{base_path}/languages/").map(&:language_code)
    end

    def translation(resource, language_code)
      translation_data = client.get("#{resource_path(resource.slug)}translation/#{language_code}/")
      return if translation_data == 'Not Found'
      Translation.new(translation_data, resource)
    end

    private

    def resource_path(resource_slug)
      "#{base_path}/resource/#{resource_slug}/"
    end

    def base_path
      "/project/#{slug}"
    end

    def initialize_resources(resource_data_array)
      resource_data_array.map do |resource_data|
        Resource.new(resource_data, self)
      end
    end
  end
end
