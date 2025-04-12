# frozen_string_literal: true

module CodeKindly
  module Utils
    class Dir
      SKIP_DIRS = ['.', '..', '.DS_Store', '.keep'].map(&:freeze).freeze

      class << self
        def all(path)
          require 'fileutils'
          return [] unless ::Dir.exist?(path)

          files = ::Dir.entries(path)
          files.reject! { |f| SKIP_DIRS.include? f }
          files.sort
        end

        def find(path)
          require 'fileutils'
          all(path).select { |entry| ::File.directory?("#{path}/#{entry}") }
        end
      end
    end
  end
end
