require "smart_holiday/officials/german_official"

module SmartHoliday
  class Official
    attr_reader :state

    def initialize state:
      @state = state
    end

    def list
      service.new(state: state).list
    end

    private

    def service
      case country
      when :de then Officials::German
      else raise NotProvidedError, "No service for #{country} officals provided."
      end
    end

    def country
      raise InvalidStateError, "#{state} not included in states list." unless state_valid?
      valid_states.each { |country, states| return country if states.include?(state) }
    end

    def state_valid?
      valid_states.values.flatten.include?(state)
    end

    def valid_states
      @valid_states ||= {
        de: Officials::German.states
      }
    end
  end

  class NotProvidedError < StandardError
  end

  class InvalidStateError < StandardError
  end
end
