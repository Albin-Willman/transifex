module Transifex
  # Holds Transifex resource data
  class Resource
    attr_accessor :name, :type, :slug, :main_language, :project

    def initialize(data, project)
      @name          = data.name
      @type          = data.i18n_type
      @slug          = data.slug
      @main_language = data.source_language_code
      @project       = project
    end
  end
end
