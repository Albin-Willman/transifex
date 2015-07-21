require 'transifex/request'

module Transifex
  class Account
    include Transifex::Request

    def initialize(username, password)
      set_credentials(username, password)
    end

    def projects
      get('/projects/')
    end

    def project(name)
      get("/project/#{name}/")
    end
  end
end
