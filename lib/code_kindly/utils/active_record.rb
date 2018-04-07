module CodeKindly
  module Utils
    class ActiveRecord
      class << self
        def config (name = nil)
          name ||= Rails.env
          YAML.load_file(::File.join(Rails.root, %w[config database.yml]))[name]
        end
      end
    end
  end
end
