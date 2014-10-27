require "bundler/gem_tasks"
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError # Don't die if rspec not available
end
