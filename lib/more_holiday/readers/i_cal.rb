require "icalendar"

module MoreHoliday
  module Readers
    class ICal
      attr_reader :path, :for_year, :raw, :serialized

      def initialize path, for_year: Date.today.year
        @path = path
        @raw = File.read(path)
        @for_year = for_year
      end

      def serialize
        extract_events
        remove_out_of_scope_events
        @serialized.sort!
      end

      private

      def extract_events
        Icalendar::Calendar.parse(raw).map do |calendar|
          calendar.events.map do |event|
            if !event.rrule.first.nil?
              complete_frequent(event)
            else
              add_event(event.dtstart, event.summary)
            end
          end
        end
      end

      def add_event date, summary
        @serialized = Array.new unless @serialized.is_a?(Array)
        @serialized << [date.to_s, summary.to_s]
      end

      def complete_frequent event
        rules = event.rrule.first

        case rules.frequency
        when "YEARLY"
          year, month, day = event.dtstart.year, event.dtstart.month, event.dtstart.day

          if rules.interval.is_a?(Integer)
            while year <= for_year
              add_event(Date.parse("#{year}-#{month}-#{day}"), event.summary)
              year += rules.interval
            end
          end
        end
      end

      def remove_out_of_scope_events
        @serialized.reject! { |event| Date.parse(event.first).year != for_year  }
      end
    end
  end
end
