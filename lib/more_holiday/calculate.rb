require "more_holiday/connector"
require "more_holiday/reader"

module MoreHoliday
  class Calculate
    attr_reader :state, :available_days, :officials_file_path, :year

    def initialize state:, available_days: 0, officials_file_path: nil, year: Date.today.year
      @state = state
      @available_days = available_days
      @officials_file_path = officials_file_path
      @year = year
    end

    def holidays
      {
        holidays: [],
        officials: officials,
        info: {
          state: state,
          officials_source: officials_source
        }
      }
    end

    private

    def connector
      @connector ||= Connector.new(state)
    end

    def officials
      @officials ||=
        if officials_file_path.nil?
          connector.list
        else
          Reader.new(officials_file_path, for_year: year).list
        end
    end

    def officials_source
      return "file" unless officials_file_path.nil?
      connector.source
    end
  end
end
