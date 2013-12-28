# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('lib')
require 'cape-cod/version'

Gem::Specification.new do |s|
  s.name                  = 'cape-cod'
  s.version               = CapeCod::VERSION
  s.date                  = Time.now.strftime('%Y-%m-%d')
  s.summary               = 'Fancy terminal output with ANSI escape codes.'
  s.homepage              = 'http://github.com/fuadsaud/cape-cod'
  s.email                 = 'fuadfsaud@gmail.com'
  s.author                = 'Fuad Saud'
  s.license               = 'MIT'
  s.has_rdoc              = false
  s.required_ruby_version = '>= 1.9.3'

  s.files             = %w( README.md Rakefile LICENSE.md )
  s.files            += Dir.glob('lib/**/*')
  s.test_files        = Dir.glob('spec/**/*')

  s.description       = <<-DESCRIPTION
CapeCod offers you simple stupid way of colorizing and applying effects to your
terminal output, by appending ANSI escape sequences to your strings.
DESCRIPTION

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.0.0.beta1'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rubocop'
end
