require "more_holiday/readers/i_cal"

module MoreHoliday
  class Reader
    attr_reader :path, :year, :content

    def initialize path, year: Date.today.year
      @path = path
      @year = year
    end

    def list
      @content = read_file
    end

    private

    def read_file
      File.open(path, "r") do |file|
        case File.extname(file).delete(".")
        when "ics" then Readers::ICal.new(file, year: year).serialize
        else
          file.close
          raise LoadError, "Type of file is not supported."
        end
      end
    end
  end
end
