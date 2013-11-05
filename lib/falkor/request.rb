require "forwardable"

module Falkor
  class Request
    extend Forwardable

    def_delegators :@connection, :get, :post, :delete, :put

    def initialize(base_url)
      @base_url     = base_url
      @connection  = create_connection
    end

    private

    def create_connection
      Faraday.new(url: @base_url) do |faraday|
        faraday.request :json

        faraday.response :logger
        faraday.response :json, :content_type => /\bjson$/

        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end