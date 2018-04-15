module CodeKindly
  module Utils
    class ActiveRecord
      class << self
        def active_record_classes_by_connection
          @active_record_classes_by_connection ||= begin
            sets = {}.with_indifferent_access
            find_active_record_classes.each do |klass|
              config_name = configurations.keys.select { |k| configurations[k]["database"] == klass.connection.current_database }.first
              config_name ||= ::Rails.env
              sets[config_name] ||= []
              sets[config_name] << klass
            end
            sets
          end
        end

        def clear_scope (scope)
          if 0 == scope.count
            puts "Nothing to clear"
          else
            puts "Clearing #{scope.count} #{scope.name} records"
            scope.delete_all
          end
        end

        def configurations
          return unless active_record_available?
          @configurations ||= YAML.load_file(::Rails.root.join(*%w[config database.yml]))
        end

        def config(name = nil)
          return unless active_record_available?
          name ||= ::Rails.env
          configurations[name]
        end

        def default_connection_class (connection = nil)
          return unless active_record_available?
          connection ||= ::Rails.env
          @default_connection_class ||= {}.with_indifferent_access
          @default_connection_class[connection] ||= active_record_classes_by_connection.fetch(connection, []).first
          @default_connection_class[connection] ||= active_record_classes_by_connection.fetch(active_record_classes_by_connection.keys).first
        end

      private

        def active_record_available?
          begin
            ::ActiveRecord
            true
          rescue NameError
            raise NotImplementedError, "ActiveRecord is not loaded."
            false
          end
        end

        def application_active_record_class? (klass)
          return false unless klass < ::ActiveRecord::Base
          return false     if klass.abstract_class
          return false     if klass.name =~ /ActiveRecord::/
          true
        end

        def find_active_record_classes
          if ::Rails.env.development?
            ::Dir.glob(::Rails.root.join("app", "models").to_s + "/**/*.rb") { |f| require f }
          end
          ObjectSpace.each_object(Class).select { |klass| application_active_record_class?(klass) }.sort_by(&:name)
        end
      end
    end
  end
end
