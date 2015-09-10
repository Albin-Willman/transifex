require 'faraday'
require 'faraday_middleware'

module Transifex
  class Request
    OPTIONS = {
      headers: {
        'Accept' => 'application/json',
        'User-Agent' => Transifex::Config::USER_AGENT,
      },
      url: Transifex::Config::BASE_URL
    }

    API_PATH = '/api/2'

    def initialize(username, password)
      @username = username
      @password = password
    end

    def get(path, params = {})
      connection.get(build_path(path), params).body
    end

    def connection
      @connection ||= make_connection
    end

    private

    def build_path(path)
      "#{API_PATH}/#{path}"
    end

    def make_connection
      Faraday.new(OPTIONS) do |builder|
        builder.use FaradayMiddleware::Mashify
        builder.use Faraday::Response::ParseJson, :content_type => /\bjson$/

        # Authentiation
        builder.basic_auth(@username, @password)

        # Request Middleware
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded

        builder.adapter :net_http
      end
    end
  end
end
