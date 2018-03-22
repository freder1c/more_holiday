require "more_holiday/importers/i_cal"

module MoreHoliday
  class Importer
    attr_reader :path, :stream, :year, :content

    def initialize year = Date.today.year
      @year = year
    end

    def from_file path
      @path = path
      @content = read_file
    end

    def from_stream stream
      @stream = stream
      @contect = read_stream
    end

    private

    def read_file
      File.open(path, "r") do |file|
        case File.extname(file).delete(".")
        when "ics" then Importers::ICal.new(File.read(file), year: year).serialize
        else
          file.close
          raise LoadError, "Type of file is not supported."
        end
      end
    end

    def read_stream
      case true
      when stream.start_with?("BEGIN:VCALENDAR")
        Importers::ICal.new(stream, year: year).serialize
      else raise StreamContentTypeError, "Could not detect content type of stream"
      end
    end

    class StreamContentTypeError < StandardError
    end
  end
end
