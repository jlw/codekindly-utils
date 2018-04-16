module CodeKindly
  module Utils
    class OS
      class << self
        def notify(message)
          require 'open3'
          _stdin, stdout, _stderr = Open3.popen3('which terminal-notifier')
          tn_path = stdout.gets
          return if tn_path.nil?
          tn_path.chomp!
          return if tn_path == ''
          Kernel.system("#{tn_path} -message \"#{message}\" -sound Submarine")
        end
      end
    end
  end
end
