# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'code_kindly/utils/version'

Gem::Specification.new do |spec|
  spec.name          = 'codekindly-utils'
  spec.version       = CodeKindly::Utils::VERSION
  spec.authors       = ['Jeremy Weathers']
  spec.email         = ['jeremy@codekindly.com']

  spec.summary       = 'These are small utilities that I like to have around in my projects.'
  spec.description   = "There is nothing terribly unique or interesting here and there are almost certainly better ways to do things than this. These are little snippets I've found useful in the past and continue to use through inertia."
  spec.homepage      = 'https://github.com/jlw/codekindly-utils'
  spec.license       = 'MIT'

  spec.files         = Dir["CONTRIBUTING.md", "LICENSE.txt", "README.md", "lib/**/*"]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2'

  spec.add_dependency 'highline'
  spec.add_dependency 'map'

  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sqlite3'
end
