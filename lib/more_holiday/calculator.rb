module MoreHoliday
  class Calculator
    attr_accessor :holidays, :available_days
    attr_reader :suggestions


    def initialize holidays, available_days
      @holidays = holidays
      @available_days = available_days
    end

    def suggestions
      @suggestions = []
      count = available_days
      nwd = non_working_day_numbers
      range = 1

      while count > 0 do
        bridges = find_bridges(nwd, range)

        bridges.each do |bridge|
          @suggestions << Date.ordinal(year, bridge).to_s
          count -= 1
          break if count == 0
        end

        range += 1
      end

      @suggestions.sort!
    end

    private

    def year
      @year ||= holidays.any? ? Date.parse(holidays.first.first).year : nil
    end

    def first_sunday_of_year
      day = 1
      day += 1 until Date.new(year,1,day).sunday? == true
      day
    end

    def holiday_day_numbers
      holidays.map{ |date, summary| Date.parse(date).yday }
    end

    def week_end_day_numbers
      range = Date.new(year,1,1)..Date.new(year,12,31)
      grouped_days = range.group_by(&:wday)
      (grouped_days[6] + grouped_days[0]).map(&:yday).sort
    end

    def non_working_day_numbers
      (holiday_day_numbers + week_end_day_numbers).uniq.sort
    end

    def find_bridges days, size
      bridges = Array.new
      range = size + 1

      for pointer in 0..(days.size-2)
        if days[pointer + 1] - days[pointer] == range
          for day in 1..size
            bridges << (days[pointer] + day)
          end
        else
          next
        end
      end

      bridges
    end
  end
end
