module SmartHoliday
  module Officials
    class German
      attr_reader :state

      def initialize state:
        @state = state
      end

      def list
        []
      end

      def self.states
        [
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
      end
    end
  end
end
