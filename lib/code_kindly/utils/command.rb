# frozen_string_literal: true

module CodeKindly
  module Utils
    class Command
      include Presence

      class << self
        def run(command)
          new(command).run
        end
      end

      attr_reader :command

      def initialize(command)
        @command = command
      end

      def run
        require 'open3'
        command = @command
        command.join(' ') if command.is_a?(Array)
        @std_in, @std_out, @std_err = Open3.capture3(command)
        self
      end

      def result
        return nil if blank? @std_out

        @std_out.chomp!
        blank? @std_out ? nil : @std_out
      end
    end
  end
end
