module CodeKindly
  module Utils
    class Database
      class << self
        def clear_scope (scope)
          if 0 == scope.count
            puts "Nothing to clear"
          else
            puts "Clearing #{scope.count} #{scope.name} records"
            scope.delete_all
          end
        end
      end
    end
  end
end
