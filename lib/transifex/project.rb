require 'transifex/paths'

module Transifex
  # Holds data for a Transifex project
  class Project
    attr_reader :name, :description, :slug, :main_language, :client

    def initialize(project_data, client)
      @name          = project_data.name
      @description   = project_data.description
      @slug          = project_data.slug
      @paths         = Paths.new(@slug)
      @main_language = project_data.source_language_code
      @client        = client
    end

    def resources
       @resources ||= begin
         client.get(@paths.resources).map do |resource_data|
           Resource.new(resource_data, self)
         end
       end
    end

    def resource(resource_slug)
      resource_data = client.get(@paths.resource(resource_slug))
      return if resource_data == 'Not Found'
      Resource.new(resource_data, self)
    end

    def languages
      @languages ||= client.get(@paths.languages).map(&:language_code)
    end

    def translation(resource, language_code)
      translation_data = client.get(@paths.translations(resource.slug, language_code))
      return if translation_data == 'Not Found'
      Translation.new(translation_data, resource)
    end
  end
end
