require 'yaml'
module Transifex
  # Holds Transifex translations data in a hash
  class Translation
    attr_accessor :resource, :content

    def initialize(data, resource)
      @content  = data.content
      @resource = resource
    end

    def content
      case resource.type.downcase
      when 'yml' then return convert_from_yml
      else
        raise "Unrecognized content type: #{resource.type}"
      end
    end

    private

    def convert_from_yml
      @content_hash ||= YAML.load(content)
    end
  end
end
