require 'yaml'
module Transifex
  class UnkownContentTypeError < StandardError;end

  # Holds Transifex translations data in a hash
  class Translation

    attr_reader :resource

    def initialize(data, resource)
      @content  = data.content
      @resource = resource
    end

    def content
      case resource.type.downcase
      when 'yml' then return convert_from_yml
      else
        fail UnkownContentTypeError, "Unrecognized content type: #{resource.type}"
      end
    end

    private

    def convert_from_yml
      @content_hash ||= YAML.load(@content)
    end
  end
end
