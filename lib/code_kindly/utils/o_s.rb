module CodeKindly
  module Utils
    class OS
      class << self
        def notify (message)
          require "open3"
          stdin, stdout, stderr = Open3.popen3("which terminal-notifier")
          tn_path = stdout.gets
          if tn_path.present?
            Kernel.system("#{tn_path.chomp} -message \"#{message}\" -sound Submarine")
          end
        end
      end
    end
  end
end
