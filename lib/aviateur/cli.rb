require 'thor'

module Ec2list
  class CLI < Thor
    default_command :get_data

    option :u, type: :string, default: 'http://services.inflightpanasonic.aero/inflight/services/flightdata/v1/flightdata'
    
    desc "get_data", "get current flight data"
    def get_data
      @client = Aviateur::Client.new options[:u]
      @parser = Aviateur::Parser.new client.last_response.body

      puts @parser.map_url_to_current_position
    end
  end
end
