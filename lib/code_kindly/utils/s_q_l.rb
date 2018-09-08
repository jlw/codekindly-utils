# frozen_string_literal: true

module CodeKindly
  module Utils
    class SQL
      class << self
        def method_missing(method, *args)
          m_name = method.to_s
          return process(m_name, *args) if respond_to_missing?(m_name)
          select_mn = 'select_' + m_name
          return process(select_mn, *args) if respond_to_missing?(select_mn)
          super
        end

        def respond_to_missing?(method, _include_all = false)
          return false unless default_connection_class
          default_connection_class.connection.respond_to?(method)
        end

        protected

        def default_connection_class
          @default_connection_class ||= begin
            CodeKindly::Utils::ActiveRecord.default_connection_class
          end
        end

        def process(method_name, query, connection_class = NilClass)
          connection_class = find_connection_class(query, connection_class)
          query = query.to_sql if query.is_a?(::ActiveRecord::Relation)
          connection_class.connection.send(method_name, query)
        end

        private

        def find_connection_class(query, klass)
          return query.klass if query.is_a?(::ActiveRecord::Relation)
          if klass.respond_to? :to_sym
            klass = CodeKindly::Utils::ActiveRecord.default_connection_class(klass)
          else
            klass = klass.class unless klass.is_a?(Class)
            klass = NilClass if klass < ::ActiveRecord::Base
          end
          klass = default_connection_class if klass == NilClass
          klass
        end
      end
    end
  end
end
