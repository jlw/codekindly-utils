module CodeKindly
  module Utils
    module Deprecation
      class << self
        private

        def deprecate(old_m, new_m = nil, version = nil)
          msg = "[DEPRECATION] `#{old_m}` is deprecated"
          version ? " and will be removed in version #{version}." : '.'
          msg += " Please use `#{new_m}` instead." if new_m
          warn msg
        end
      end

      private

      def deprecate(old_m, new_m = nil, version = nil)
        self.class.deprecate(old_m, new_m, version)
      end
    end
  end
end
