require "more_holiday/reader"
require "more_holiday/cache/file"

require "more_holiday/connectors/ifeiertage/ifeiertage"

module MoreHoliday
  class Connector
    attr_reader :state, :file_path, :year

    def initialize state, file_path: nil, year: Date.today.year
      @state = state
      @file_path = file_path
      @year = year
    end

    def holidays
      @holidays ||=
        if file_path.nil?
          connect
        else
          Reader.new(file_path, year: year).list
        end
    end

    def connect
      cache.resolve Proc.new { Reader.new(service::Connect.get(state), year: year).list }
    end

    def source
      return "file" unless file_path.nil?
      service::SOURCE
    end

    private

    def service
      @service ||=
        case country
        when "de" then nil # placeholder
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
        "de" => [
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

    def cache
      @cache ||= Cache::File.new(file_name: year, folder_path: File.join("holidays", country, state))
    end

    class NotProvidedError < StandardError
    end

    class InvalidStateError < StandardError
    end
  end
end
