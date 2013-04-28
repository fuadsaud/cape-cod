# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('lib')
require 'cape-cod/version'

Gem::Specification.new do |s|
  s.name              = 'cape-cod'
  s.version           = CapeCod::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = 'Make your strings look fancy with ANSI escape codes.'
  s.homepage          = 'http://github.com/fuadsaud/cape-cod'
  s.email             = 'fuadksd@gmail.com'
  s.authors           = ['Fuad Saud']
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE.md )
  s.files            += Dir.glob('lib/**/*')
  s.files            += Dir.glob('bin/**/*')
  s.files            += Dir.glob('man/**/*')
  s.files            += Dir.glob('test/**/*')

  s.description       = <<-DESCRIPTION
CapeCod offers you simple stupid way of colorizing and applying effects to your
terminal output, by appending ANSI escape sequences to your strings.
DESCRIPTION

  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
end
