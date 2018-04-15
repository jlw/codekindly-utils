module CodeKindly
  module Utils
    class Shell
      class << self
        def run (command)
          require "open3"
          command = command.join(" ") if command.is_a?(Array)
          stdout_str, stderr_str, status = Open3.capture3(command)
        end
      end
    end
  end
end
