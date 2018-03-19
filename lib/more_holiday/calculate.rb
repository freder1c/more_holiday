require "more_holiday/officials/official"

module MoreHoliday
  class Calculate
    attr_reader :state, :days_count, :config, :officials

    def initialize state:, days_count:, config: {}
      @state = state
      @days_count = days_count
      @config = config
    end

    def holidays
      get_officials

      {
        holidays: [],
        officials: officials
      }
    end

    private

    def get_officials
      @officials ||= Official.new(state: state).list
    end

  end
end