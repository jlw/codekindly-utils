module CodeKindly
  module Utils
    class Boolean
      # modified from ActiveRecord::ConnectionAdapters::Column (4.2.9)
      TRUE_VALUES  = [true, 1, "1", "t", "T", "true", "TRUE", "on", "ON", "y", "yes"]
      FALSE_VALUES = [false, 0, "0", "f", "F", "false", "FALSE", "off", "OFF", "n", "no"]

      class << self
        def from (value)
          return true  if is_true?(value)
          return false if is_false?(value)
          nil
        end

        def is_false? (value)
          return true if FALSE_VALUES.include?(value)
          if value.respond_to?(:downcase)
            return true if FALSE_VALUES.include?(value.downcase)
          end
          false
        end

        def is_true? (value)
          return true if TRUE_VALUES.include?(value)
          if value.respond_to?(:downcase)
            return true if TRUE_VALUES.include?(value.downcase)
          end
          false
        end
      end
    end
  end
end
