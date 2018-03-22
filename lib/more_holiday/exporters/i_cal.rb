require "icalendar"

module MoreHoliday
  module Exporters
    class ICal
      attr_reader :content, :serialized

      def initialize content
        @content = content
      end

      def serialize
        @cal = Icalendar::Calendar.new
        serialize_events
        @serialized = @cal.to_ical
      end

      private

      def serialize_events
        @content.each do |date, summary|
          @cal.event do |e|
            e.dtstart     = Icalendar::Values::Date.new(date.delete("-"))
            e.dtend       = Icalendar::Values::Date.new(date.delete("-"))
            e.summary     = summary
            e.ip_class    = "MoreHoliday"
          end
        end
      end
    end
  end
end
