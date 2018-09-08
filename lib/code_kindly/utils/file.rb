# frozen_string_literal: true

module CodeKindly
  module Utils
    class File
      include Presence

      class << self
        def all(path)
          CodeKindly::Utils::Dir.all path
        end

        def choose_from_options(dir_path, h_l = nil)
          require 'highline'
          h_l ||= HighLine.new
          file_opts = file_options(dir_path)
          return nil if blank? file_opts
          msg = file_opts.inject('') { |(k, v), m| m + "\n  #{k}: #{v}" }
          option = h_l.ask("Select a file:#{msg}\n  0: None", Integer)
          file_path = file_opts.fetch(option, nil)
          return if file_path.nil?
          ::File.join(dir_path, file_path)
        end

        def file_options(path)
          require 'map'
          options = Map.new
          key = 0
          find(path).each do |file|
            options[key += 1] = file
          end
          options
        end

        def find(path)
          require 'fileutils'
          all(path).select { |entry| ::File.file?("#{path}/#{entry}") }
        end

        # move to trash (or delete) existing downloaded files
        # sudo gem install osx-trash (http://www.dribin.org/dave/blog/archives/2008/05/24/osx_trash/)
        def trash!(file_string)
          Kernel.system(command_to_trash_files(file_string))
        end

        private

        def command_to_trash_files(file_string)
          return if Command.run("ls #{file_string}").result.nil?
          trash = OS.which('trash')
          if trash then "#{trash.chomp} #{file_string}"
          elsif ::File.directory?('~/.Trash') then "mv #{file_string} ~/.Trash"
          else "rm #{file_string}"
          end
        end
      end
    end
  end
end
