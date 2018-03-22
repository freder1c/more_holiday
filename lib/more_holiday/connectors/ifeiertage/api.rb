require "net/http"
require "fileutils"

module MoreHoliday
  module Ifeiertage
    class Api
      attr_reader :state

      def get state
        @state = state
        response = Net::HTTP.get_response(URI(url))
        raise ConnectionError, "Can't connect to #{SOURCE}" unless response.is_a?(Net::HTTPSuccess)
        response.body
      end

      private

      def url
        "#{SOURCE}/calendar.php?bl=#{state}&o=1&t=dnl"
      end

      class ConnectionError < StandardError
      end
    end
  end
end
