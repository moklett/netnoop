require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "netnoop"
    gem.summary = %Q{Collects and stores your outgoing HTTP requests for later inspection}
    gem.description = %Q{Collects and stores your outgoing HTTP requests in NetNoop.requests for later inspection, usually in your test assertions or matchers.\n\nCan be used in conjunction with FakeWeb to disable outbound HTTP requests while also making the contents of those requests visible.}
    gem.email = "michael@webadvocate.com"
    gem.homepage = "http://github.com/moklett/netnoop"
    gem.authors = ["Michael Klett"]
    gem.add_dependency "fakeweb"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "jeweler"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "netnoop #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
