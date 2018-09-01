
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "code_kindly/utils/version"

Gem::Specification.new do |spec|
  spec.name          = "codekindly-utils"
  spec.version       = CodeKindly::Utils::VERSION
  spec.authors       = ["Jeremy Weathers"]
  spec.email         = ["jeremy@codekindly.com"]

  spec.summary       = %q{These are small utilities that I like to have around in my projects.}
  spec.description   = %q{There is nothing terribly unique or interesting here and there are almost certainly better ways to do things than this. These are little snippets I've found useful in the past and continue to use through inertia.}
  spec.homepage      = "https://github.com/jlw/codekindly-utils"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.2"

  spec.add_dependency "highline"
  spec.add_dependency "map"

  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.55"
end
