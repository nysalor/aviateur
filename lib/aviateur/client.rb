require 'net/http'
require 'uri'

module Aviateur
  class Client < Base
    attr_reader :last_response

    def initialize(endpoint = '')
      @endpoint = endpoint
      @url = URI.parse(endpoint)
    end

    def available?
      res = Net::HTTP.start(@url) {|http|
        http.head('/flightdata')
      }
      res == '200'
    end

    def get_data
      @last_response = Net::HTTP.start(@url.host, @url.port) {|http|
        http.get(@url.path)
      }
    end
  end
end
