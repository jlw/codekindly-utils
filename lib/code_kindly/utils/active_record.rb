# frozen_string_literal: true

require 'active_record'

module CodeKindly
  module Utils
    class ActiveRecord
      include Deprecation

      RAILS = Kernel.const_defined?(:Rails) ? ::Rails : nil

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
          configs[name || default_name]
        end

        def configs # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          @configs ||= ::ActiveRecord::Base.configurations
          if @configs.class.name == 'ActiveRecord::DatabaseConfigurations' # rubocop:disable Style/ClassEqualityComparison
            @configs = @configs.configs_for.each_with_object({}) do |config, hash|
              hash[config.env_name] = config.config
            end
          end
          return @configs unless @configs == {}
          return @configs unless RAILS.respond_to?(:root)

          file = RAILS.root.join('config', 'database.yml')
          return @configs unless ::File.readable?(file)

          @configs = YAML.load(::File.read(file)) # rubocop:disable Security/YAMLLoad
        end

        def configurations
          deprecate :configurations, :configs, :'0.1.0'
          configs
        end

        def default_connection_class(connection = nil)
          connection ||= default_name
          @default_connection_class ||= {}.with_indifferent_access
          @default_connection_class[connection] ||= begin
            it = classes_by_connection.fetch(connection, []).first
            key = classes_by_connection.keys.first
            it ||= classes_by_connection.fetch(key).first
            it
          end
        end

        private

        def application_active_record_class?(klass)
          return false unless klass < ::ActiveRecord::Base
          return false     if klass.abstract_class
          return false     if klass.name =~ /ActiveRecord::/
          return false     if Presence.blank?(klass.name)

          true
        rescue NoMethodError
          false
        end

        def default_name
          @default_name ||= RAILS.try(:env) || configs.keys.first || 'default'
        end

        def find_classes
          load_classes_in_development
          ObjectSpace.each_object(Class).select do |klass|
            application_active_record_class?(klass)
          end.sort_by(&:name)
        end

        def find_classes_by_connection # rubocop:disable Metrics/AbcSize
          sets = {}.with_indifferent_access
          find_classes.each do |klass|
            config_name = configs.keys.select do |k|
              configs[k]['database'] == klass.connection.current_database
            end.first
            config_name ||= default_name
            sets[config_name] ||= []
            sets[config_name] << klass
          end
          sets
        end

        def load_classes_in_development
          return unless RAILS.try(:env).try(:development?)

          ::Dir.glob(RAILS.root.join('app/models/**/*.rb').to_s) do |f|
            klass = ::File.basename(f, '.rb').classify
            next if Kernel.const_defined? klass

            require f
          end
        end
      end
    end
  end
end
