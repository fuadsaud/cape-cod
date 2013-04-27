require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

desc 'Start an irb session with cape-cod loaded'
task :console do
  if `which pry`.empty?
    system('irb -rubygems --require ./lib/cape-cod.rb')
  else
    system('pry --require ./lib/cape-cod.rb')
  end
end

desc 'run all specs'
task default: :spec
