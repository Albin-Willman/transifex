module Transifex
  # Transifex base config
  class Paths
    attr_reader :project_slug

    def self.projects
      '/projects/'
    end

    def self.project(name)
      "/project/#{name}/"
    end

    def initialize(project_slug)
      @project_slug = project_slug
    end

    def resources
      "/project/#{project_slug}/resources/"
    end

    def resource(resource_slug)
      "/project/#{project_slug}/resource/#{resource_slug}/"
    end

    def languages
      "/project/#{project_slug}/languages/"
    end

    def translations(resource_slug, language_code)
      "/project/#{project_slug}/resource/#{resource_slug}/translation/#{language_code}/"
    end
  end
end
