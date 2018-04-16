module CodeKindly
  module Utils
    class Boolean
      include Deprecation

      # modified from ActiveRecord::ConnectionAdapters::Column (4.2.9)
      TRUES  = [true, 1, '1', 't', 'true', 'on', 'y', 'yes']
               .map(&:freeze).freeze
      FALSES = [false, 0, '0', 'f', 'false', 'off', 'n', 'no']
               .map(&:freeze).freeze

      class << self
        def from(value)
          return true  if true?(value)
          return false if false?(value)
          nil
        end

        def false?(value)
          return true if FALSES.include?(value)
          if value.respond_to?(:downcase)
            return true if FALSES.include?(value.downcase)
          end
          false
        end

        def true?(value)
          return true if TRUES.include?(value)
          if value.respond_to?(:downcase)
            return true if TRUES.include?(value.downcase)
          end
          false
        end

        def is_false?(value)
          deprecation :is_false?, :false?, '0.1.0'.freeze
          false?(value)
        end

        def is_true?(value)
          deprecation :is_true?, :true?, '0.1.0'.freeze
          true?(value)
        end
      end
    end
  end
end
