module MoreHoliday
  module Ifeiertage
    class Connect
      attr_reader :state

      def initialize state
        @state = converted(state)
      end

      def self.get state
        new(state).get
      end

      def get
        cache.resolve Proc.new { api.get(state) }
      end

      private

      def api
        @api ||= Api.new
      end

      def cache
        @cache ||= Cache::File.new(file_name: state, folder_path: cache_base_folder)
      end

      def cache_base_folder
        File.join("connectors", "ifeiertage")
      end

      def converted state
        {
          "Baden-Württemberg" => "bw",
          "Bavaria" => "by",
          "Berlin" => "be",
          "Brandenburg" => "bb",
          "Bremen" => "hb",
          "Hamburg" => "hh",
          "Hesse" => "he",
          "Lower Saxony" => "ni",
          "Mecklenburg-Vorpommern" => "mv",
          "North Rhine-Westphalia" => "nw",
          "Rhine-Palatinate" => "rp",
          "Saarland" => "sl",
          "Saxony" => "sn",
          "Saxony-Anhalt" => "st",
          "Schleswig-Holstein" => "sh",
          "Thuringia" => "th"
        }[state]
      end
    end
  end
end
