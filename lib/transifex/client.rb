require 'transifex/request'
require 'transifex/paths'

module Transifex
  # Holds Transifex account credentials and projects
  class Client
    include Transifex::Request

    def initialize(username, password)
      set_credentials(username, password)
      @fetched_projects = {}
    end

    def projects
      @projects ||= initialize_projects(get(Paths.projects))
    end

    def project(name)
      return @fetched_projects[name] if @fetched_projects[name]

      data = get(Paths.project(name))
      return if data == 'Not Found'
      @fetched_projects[name] = Project.new(data, self)
    end

    private

    def initialize_projects(project_data_array)
      project_data_array.map do |project_data|
        Project.new(project_data, self)
      end
    end
  end
end
