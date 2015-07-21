module Transifex
  class Translation
    attr_accessor :resource, :content

    def initialize(data, resource)
      @content  = data.content
      @resource = resource
    end
  end
end
