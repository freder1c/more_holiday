require "more_holiday/exporters/i_cal"
require "fileutils"

module MoreHoliday
  class Exporter
    attr_reader :content

    def initialize content
      @content = content
    end

    def to_file path, type: "ical"
      output_base_path = path || Dir.pwd
      data, extension = serialize(type)
      complete_path = File.join(output_base_path, "MoreHoliday.#{extension}")
      FileUtils.mkdir_p(output_base_path)
      File.write(complete_path, data)
      complete_path
    end

    def to_stream type
      serialize(type).first
    end

    private

    def serialize type
      case type
      when "ical" then [Exporters::ICal.new(content).serialize, "ics"]
      else raise NotSupportedError, "Type of file is not supported."
      end
    end

    class NotSupportedError < StandardError
    end
  end
end
