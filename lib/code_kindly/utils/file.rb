module CodeKindly
  module Utils
    class File
      class << self
        def all (path)
          CodeKindly::Utils::Dir.all path
        end

        def choose_from_options (task, h = nil)
          require "highline"
          h ||= HighLine.new
          dir_path = ::File.join(Rails.root, "db", "data", task.name.split(":").last)
          file_opts = file_options(dir_path)
          return nil if file_opts.blank?
          msg = "Select an existing file:"
          file_opts.each do |k,v|
            msg += "\n  #{k}: #{v}"
          end
          msg += "\n  0: None of the above"
          option = h.ask(msg, Integer)
          file_path = file_opts.fetch(option, nil)
          if file_path.present?
            file_path = ::File.join(dir_path, file_path)
          end
          file_path
        end

        def file_options (path)
          require 'map'
          options = Map.new
          key = 0
          find(path).each do |file|
            options[key+=1] = file
          end
          options
        end

        def find (path)
          require 'fileutils'
          all(path).select { |entry| ::File.file?("#{path}/#{entry}") }
        end

        def trash! (file_string)
          require 'open3'
          stdin, stdout, stderr = Open3.popen3("ls #{file_string}")
          if stdout.gets
            # move to trash (or delete) existing downloaded files
            # sudo gem install osx-trash (http://www.dribin.org/dave/blog/archives/2008/05/24/osx_trash/)
            stdin, stdout, stderr = Open3.popen3('which trash')
            trash = stdout.gets
            command = case
              when trash then "#{trash.strip} #{file_string}" # output of `which` has ending \n
              when ::File.directory?('~/.Trash') then "mv #{file_string} ~/.Trash"
              else "rm #{file_string}"
            end
            Kernel.system(command)
          end
        end
      end
    end
  end
end
