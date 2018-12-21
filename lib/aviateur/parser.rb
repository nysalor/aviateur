require 'json'

module Aviateur
  class Parser < Base
    %w(decompression weight_on_wheels all_doors_closed x2_pa_state fltdata_ground_speed fltdata_time_to_destination fltdata_wind_speed fltdata_mach fltdata_true_heading fltdata_gmt fltdata_outside_air_temp fltdata_head_wind_speed fltdata_date fltdata_distance_to_destination fltdata_altitude fltdata_present_position_latitude fltdata_present_position_longitude fltdata_destination_latitude fltdata_destination_longitude fltdata_destination_id fltdata_departure_id fltdata_flight_number fltdata_destination_baggage_id fltdata_departure_baggage_id airframe_tail_number flight_phase gmt_offset_departure gmt_offset_destination route_id fltdata_time_at_origin fltdata_time_at_destination fltdata_distance_from_origin fltdata_distance_traveled fltdata_estimated_arrival_time fltdata_time_at_takeoff fltdata_departure_latitude fltdata_departure_longitude pdi_fltdata_departure_iata pdi_fltdata_departure_time_scheduled pdi_fltdata_arrival_iata fltdata_wind_direction media_date extv_channel_listing_version disclaimer).each do |name|
      attr_reader name
    end

    def initialize(body)
      super body
      parse_keys
    end

    def parse_keys
      @raw.each do |k, v|
        instance_variable_set "@#{k.sub('td_id_','')}", v
      end
    end

    def flightdata(name)
      send "fltdata_#{name}"
    end

    def latitude
      coordinate :present_position_latitude
    end

    def longitude
      coordinate :present_position_longitude
    end

    def coordinate(name)
      flightdata(name).to_i.quo(1000).to_f
    end

    def map_url_to_current_position
      "https://www.google.co.jp/maps?q=#{latitude},#{longitude}"
    end
  end
end
