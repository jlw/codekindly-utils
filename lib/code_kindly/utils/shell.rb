module CodeKindly
  module Utils
    class Shell
      include Deprecation

      class << self
        def run(command)
          deprecate :'Shell.run', :'Command.run', :'0.1.0'
          require 'open3'
          command = command.join(' ') if command.is_a?(Array)
          Open3.capture3 command
        end
      end
    end
  end
end
