# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sakenote/version'

Gem::Specification.new do |spec|
  spec.name          = "sakenote"
  spec.version       = Sakenote::VERSION
  spec.authors       = ["fukayatsu"]
  spec.email         = ["fukayatsu@gmail.com"]
  spec.description   = %q{Sakenote API client}
  spec.summary       = %q{Sakenote API client}
  spec.homepage      = "https://github.com/fukayatsu/sakenote"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.8.8"
  spec.add_dependency "faraday_middleware", "~> 0.9.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "dotenv"
end
