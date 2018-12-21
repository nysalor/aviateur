require 'json'

module Aviateur
  class Base
    attr_reader :body, :raw

    def initialize(body)
      @body = body
      @raw = JSON.parse @body
    end
  end
end
