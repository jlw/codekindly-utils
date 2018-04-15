module CodeKindly
  module Utils
    class SQL
      class << self
        def method_missing (method, *args)
          method_name = method.to_s
          return process(method_name, *args) if respond_to_missing?(method_name)
          select_method_name = "select_" + method_name
          return process(select_method_name, *args) if respond_to_missing?(select_method_name)
          super
        end

        def respond_to_missing? (method, _include_all = false)
          default_connection_class && default_connection_class.connection.respond_to?(method)
        end

      protected

        def default_connection_class
          @default_connection_class ||= CodeKindly::Utils::ActiveRecord.default_connection_class
        end

        def process (method_name, query, connection_class = nil)
          if query.is_a?(::ActiveRecord::Relation)
            connection_class = query.klass
            query = query.to_sql
          else
            if connection_class.respond_to? :to_sym
              connection_class = CodeKindly::Utils::ActiveRecord.default_connection_class(connection_class)
            else
              connection_class = connection_class.class unless connection_class.is_a?(Class)
              connection_class = nil if connection_class < ::ActiveRecord::Base
            end
            connection_class ||= default_connection_class
          end
          connection_class.connection.send(method_name, query)
        end
      end
    end
  end
end
