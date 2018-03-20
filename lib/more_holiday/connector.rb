module MoreHoliday
  class Connector
    attr_reader :state, :for_year

    def initialize state, for_year: Date.today.year
      @state = state
      @for_year = for_year
    end

    def list
      service.new(state, for_year: for_year).list
    end

    private

    def service
      case country
      when :de then nil # placeholder
      else raise NotProvidedError, "No service for #{country} officals provided."
      end
    end

    def state_valid?
      countries.values.flatten.include?(state)
    end

    def country
      raise InvalidStateError, "#{state} not included in states list." unless state_valid?
      countries.each { |country, states| return country if states.include?(state) }
    end

    def countries
      @countries ||= {
        de: [
          "Baden-Württemberg",
          "Bavaria",
          "Berlin",
          "Brandenburg",
          "Bremen",
          "Hamburg",
          "Hesse",
          "Lower Saxony",
          "Mecklenburg-Vorpommern",
          "North Rhine-Westphalia",
          "Rhine-Palatinate",
          "Saarland",
          "Saxony",
          "Saxony-Anhalt",
          "Schleswig-Holstein",
          "Thuringia"
        ]
      }
    end
  end

  class NotProvidedError < StandardError
  end

  class InvalidStateError < StandardError
  end
end
