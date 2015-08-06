require 'transifex/version'

module Transifex
  # Transifex base config
  module Config
    BASE_URL = 'https://www.transifex.com'
    USER_AGENT = "transifex #{Transifex::VERSION}"
    VALID_OPTIONS = [:username, :password]

    attr_accessor *VALID_OPTIONS
  end
end
