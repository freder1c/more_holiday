require "more_holiday/connector"
require "more_holiday/calculator"

module MoreHoliday
  class Holiday
    attr_reader :state, :available_days, :file_path, :year

    def initialize state, available_days: 0, file_path: nil, year: Date.today.year
      @state = state
      @available_days = available_days
      @file_path = file_path
      @year = year
    end


    def make_more_out_of_may_holidays!
      suggestions
    end

    def suggestions
      {
        holidays_to_take: calculator.suggestions,
        official_holidays: connector.holidays,
        info: {
          state: connector.state,
          officials_source: connector.source
        }
      }
    end

    private

    def connector
      @connector ||= Connector.new(state, file_path: file_path, year: year)
    end

    def calculator
      @calculator ||= Calculator.new(connector.holidays, available_days)
    end
  end
end
