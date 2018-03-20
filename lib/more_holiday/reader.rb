require "more_holiday/readers/i_cal"

module MoreHoliday
  class Reader
    attr_reader :path, :for_year, :content

    def initialize path, for_year: Date.today.year
      @path = path
      @for_year = for_year
    end

    def list
      @content = read_file
    end

    private

    def read_file
      File.open(path, "r") do |file|
        case File.extname(file).delete(".")
        when "ics" then Readers::ICal.new(file, for_year: for_year).serialize
        else
          file.close
          raise LoadError, "Type of file is not supported."
        end
      end
    end
  end
end
