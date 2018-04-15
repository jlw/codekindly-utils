module CodeKindly
  module Utils
    class Dir
      class << self
        def all (path)
          require "fileutils"
          return [] unless ::Dir.exist?(path)
          files = ::Dir.entries(path)
          files.reject!{ |f| "." == f || ".." == f || ".DS_Store" == f || ".keep" == f }
          files.sort
        end

        def find (path)
          require "fileutils"
          all(path).select { |entry| ::File.directory?("#{path}/#{entry}") }
        end
      end
    end
  end
end
