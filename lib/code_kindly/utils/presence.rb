module CodeKindly
  module Utils
    module Presence
      def self.blank?(value)
        # http://apidock.com/rails/Object/blank%3F
        value.respond_to?(:empty?) ? !!value.empty? : !value
      end

      def blank?(value)
        self.class.blank?(value)
      end

      def self.present?(value)
        !blank?(value)
      end

      def present?(value)
        self.class.present?(value)
      end
    end
  end
end
