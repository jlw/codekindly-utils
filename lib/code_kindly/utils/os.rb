# frozen_string_literal: true

module CodeKindly
  module Utils
    class OS
      class << self
        def notify(message)
          return if terminal_notifier.nil?
          Command.run [
            terminal_notifier,
            "-message \"#{message}\"",
            '-sound Submarine'
          ].join(' ')
        end

        def which(program)
          Command.run("which #{program}").result
        end

        private

        def terminal_notifier
          unless instance_variable_defined? :@terminal_notifier
            @terminal_notifer = which('terminal-notifier')
          end
          @terminal_notifier
        end
      end
    end
  end
end
