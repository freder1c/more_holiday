require "fileutils"

module MoreHoliday
  module Cache
    class File
      attr_reader :file_name, :folder_path, :data

      def initialize file_name:, folder_path:
        @file_name = file_name
        @folder_path = ::File.join(cache_base_path, folder_path)
      end

      def read
        return nil if !exist? or !still_valid?
        eval ::File.read(file_path)
      rescue SyntaxError
        raise FileCacheReadError, "An error occurred while reading from file cache."
      end

      def write data
        @data = data
        FileUtils::mkdir_p(folder_path)
        !!::File.write(file_path, data)
      end

      def exist?
        ::File.exists?(file_path) and still_valid?
      end

      def resolve function
        if exist?
          read
        else
          write function.call
          data
        end
      end

      def clear!
        !!FileUtils.rm_rf(cache_base_path)
      end

      def file_path
        ::File.join(folder_path, file_name)
      end

      private

      def cache_base_path
        ::File.join("tmp", "cache")
      end

      def still_valid?
        # TODO: implement useful invalidation rule
        true
      end

      class FileCacheReadError < StandardError
      end

      class FileCacheWriteError < StandardError
      end
    end
  end
end
