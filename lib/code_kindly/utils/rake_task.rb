module CodeKindly
  module Utils
    class RakeTask
      def self.run (task)
        Rake::Task[task].reenable
        Rake::Task[task].invoke
      end
    end
  end
end
