# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thrifty_bunny/version'

Gem::Specification.new do |spec|
  spec.name          = "thrifty-bunny"
  spec.version       = ThriftyBunny::VERSION
  spec.authors       = ["Bill Siggelkow"]
  spec.email         = ["bsiggelkow@me.com"]
  spec.summary       = "RabbitMQ adapter for Apache Thrift"
  spec.description   = "RabbitMQ adapter for Apache Thrift"
  spec.homepage      = "http://github.com/bsiggelkow/thrifty-bunny"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'thrift'
  spec.add_dependency 'thin'
  spec.add_dependency 'bunny'
  spec.add_dependency 'uuidtools'
end
