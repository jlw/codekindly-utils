module CodeKindly
  module Utils
    class ActiveRecord
      include Deprecation
      include Presence

      class << self
        def active_record_classes_by_connection
          deprecate :active_record_classes_by_connection,
                    :classes_by_connection,
                    :'0.1.0'
          classes_by_connection
        end

        def classes_by_connection
          @classes_by_connection ||= find_classes_by_connection
        end

        def clear_scope(scope)
          if scope.count.zero?
            puts 'Nothing to clear'
            return
          end
          puts "Clearing #{scope.count} #{scope.name} records"
          scope.delete_all
        end

        def config(name = nil)
          return unless active_record_available?
          name ||= ::Rails.env
          configs[name]
        end

        def configs
          return unless active_record_available?
          @configs ||= begin
            config_file = ::Rails.root.join('config', 'database.yml')
            YAML.load_file config_file
          end
        end

        def configurations
          deprecate :configurations, :configs, :'0.1.0'
          configs
        end

        # rubocop:disable Metrics/AbcSize
        def default_connection_class(connection = nil)
          return unless active_record_available?
          connection ||= ::Rails.env
          @default_connection_class ||= {}.with_indifferent_access
          @default_connection_class[connection] ||= begin
            it = classes_by_connection.fetch(connection, []).first
            key = classes_by_connection.keys.first
            it ||= classes_by_connection.fetch(key).first
            it
          end
        end
        # rubocop:enable Metrics/AbcSize

        private

        def active_record_available?
          present? ::ActiveRecord
        rescue NameError
          raise NotImplementedError, 'ActiveRecord is not loaded.'
        end

        def application_active_record_class?(klass)
          return false unless klass < ::ActiveRecord::Base
          return false     if klass.abstract_class
          return false     if klass.name =~ /ActiveRecord::/
          true
        end

        def find_classes
          if ::Rails.env.development?
            model_files = ::Rails.root.join('app', 'models').to_s + '/**/*.rb'
            ::Dir.glob(model_files) { |f| require f }
          end
          ObjectSpace.each_object(Class).select do |klass|
            application_active_record_class?(klass)
          end.sort_by(&:name)
        end

        # rubocop:disable Metrics/AbcSize
        def find_classes_by_connection
          sets = {}.with_indifferent_access
          find_classes.each do |klass|
            config_name = configs.keys.select do |k|
              configs[k]['database'] == klass.connection.current_database
            end.first
            config_name ||= ::Rails.env
            sets[config_name] ||= []
            sets[config_name] << klass
          end
          sets
        end
        # rubocop:enable Metrics/AbcSize
      end
    end
  end
end
