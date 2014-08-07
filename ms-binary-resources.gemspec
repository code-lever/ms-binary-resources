# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ms/binary/resources/version'

Gem::Specification.new do |spec|
  spec.name          = 'ms-binary-resources'
  spec.version       = Ms::Binary::Resources::VERSION
  spec.authors       = ['Nick Veys']
  spec.email         = ['nick@codelever.com']
  spec.summary       = %q{Read binary resource files}
  spec.description   = %q{}
  spec.homepage      = 'https://github.com/code-lever/ms-binary-resources'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'ci_reporter', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 2.99'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-checkstyle_formatter'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-gem-adapter'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'yard'
end
