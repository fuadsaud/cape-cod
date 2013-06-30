# encoding: utf-8

require 'rake'
require 'rspec/core/rake_task'

task default: [:spec, :rubocop]

RSpec::Core::RakeTask.new

desc 'Run RuboCop static analyzer'
task :rubocop do
  system 'rubocop lib/ spec/ Gemfile Rakefile *.gemspec'
end

desc 'Start an irb session with cape-cod loaded'
task :console do
  # Do we have pry available?
  repl = system('pry -v &> /dev/null') ? 'pry' : 'irb'

  system "#{repl} --require ./lib/cape-cod.rb"
end
