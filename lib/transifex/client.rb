require 'transifex/request'

module Transifex
  # Holds Transifex account credentials and projects
  class Client
    include Transifex::Request

    def initialize(username, password)
      set_credentials(username, password)
    end

    def projects
      initialize_projects(get('/projects/'))
    end

    def project(name)
      data = get("/project/#{name}/")
      return if data == 'Not Found'
      Project.new(data, self)
    end

    private

    def resource_path(resource_slug)
      "#{base_path}/resource/#{resource_slug}/"
    end

    def initialize_projects(project_data_array)
      project_data_array.map do |project_data|
        Project.new(project_data, self)
      end
    end
  end
end
