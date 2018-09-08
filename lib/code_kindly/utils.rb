# frozen_string_literal: true

require_relative 'utils/version'

require_relative 'utils/deprecation'

require_relative 'utils/boolean'
require_relative 'utils/presence'

require_relative 'utils/command'
require_relative 'utils/dir'
require_relative 'utils/file'
require_relative 'utils/o_s'
require_relative 'utils/rake_task'
require_relative 'utils/shell'

if Kernel.const_defined? :ActiveRecord
  require_relative 'utils/active_record'
  require_relative 'utils/s_q_l'
end
