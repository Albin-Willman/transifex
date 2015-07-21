# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transifex/version'

Gem::Specification.new do |spec|
  spec.name          = "transifex"
  spec.version       = Transifex::VERSION
  spec.authors       = ["Albin Willman"]
  spec.email         = ["j.albin.willman@gmail.com"]
  spec.license       = 'MIT'

  spec.summary       = %q{A gem to help comunicate with transifex api}
  spec.description   = %q{A gem to help retreive and verify resources on transifex.}
  spec.homepage      = "https://github.com/Albin-trialbee/transifex"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.9.1'
  spec.add_dependency 'faraday_middleware', '~> 0.10.0'
  spec.add_dependency 'hashie', '~> 3.4'

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3'       #, '~> 2.0'
  spec.add_development_dependency 'guard', '~> 2'
  spec.add_development_dependency 'guard-rspec', '~> 4'
end
