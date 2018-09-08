# frozen_string_literal: true

require_relative 'code_kindly/utils'

if Kernel.const_defined? :CK
  warn '`CK` is already defined as a constant, so you will need to use' \
       ' the full `CodeKindly::Utils` module name in this project.'
else
  CK = CodeKindly::Utils
end
