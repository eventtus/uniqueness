lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uniqueness/version'

Gem::Specification.new do |spec|
  spec.name          = 'uniqueness'
  spec.version       = Uniqueness::VERSION
  spec.authors       = ['Omar Abdel-Wahab']
  spec.email         = ['owahab@gmail.com']

  spec.summary       = 'Adds unique attribute support to ActiveModel models.'
  spec.homepage      = 'https://github.com/eventtus/uniqueness'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.license       = 'MIT'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'activerecord', '>= 4.0.0'
  spec.add_dependency 'railties', '>= 4.0.0'
end
