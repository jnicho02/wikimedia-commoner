#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# Run with 'rake spec'
RSpec::Core::RakeTask.new(:spec) do |task|
#  task.rspec_opts = ['--color', '--format', 'nested']
end

# http://erniemiller.org/2014/02/05/7-lines-every-gems-rakefile-should-have/
task :console do
  require 'irb'
  require 'irb/completion'
  require 'wikimedia/commoner'
  ARGV.clear
  IRB.start
end

task :default => :test
