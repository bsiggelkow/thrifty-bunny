require "bundler/gem_tasks"
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError # Don't die if rspec not available
end

namespace :generate do

  desc 'Generate ruby example from Thrift file'
  task :example do
    outdir = 'examples/calculator'
    file = "#{outdir}/calculator_service.thrift"
    %x[thrift -gen rb --out #{outdir} #{file}]
    puts "Ruby files generated for #{file} to #{outdir}. Now go write the handler!"
  end

end
