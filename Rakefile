require 'rubygems'

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/trains.rb"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = "train"
  rdoc.rdoc_files.include('DESIGN*')
  rdoc.rdoc_files.include('PROBLEM*')
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/*.rb')
end

begin
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
    t.rcov = true
  end
rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end
