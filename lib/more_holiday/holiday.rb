require "more_holiday/connector"

module MoreHoliday
  class Holiday
    attr_reader :state, :available_days, :file_path, :year

    def initialize state:, available_days: 0, file_path: nil, year: Date.today.year
      @state = state
      @available_days = available_days
      @file_path = file_path
      @year = year
    end

    def calculate
      {
        holidays_to_take: [],
        official_holidays: connector.holidays,
        info: {
          state: connector.state,
          officials_source: connector.source
        }
      }
    end

    private

    def connector
      @connector ||= Connector.new(state: state, file_path: file_path, year: year)
    end
  end
end
