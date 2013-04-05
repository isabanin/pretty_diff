require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pretty_diff"
    gem.summary = "Library for converting unified diff format into HTML listings."
    gem.description = "PrettyDiff is a highly customizable library for creating fully featured HTML
                       listings out of unified diff format strings.
                       Include copy/paste-safe line numbers and built-in syntax highlighting."
    gem.email = "ilya.sabanin@gmail.com"
    gem.homepage = "http://github.com/isabanin/pretty_diff"
    gem.authors = ["Ilya Sabanin"]
    gem.add_development_dependency "shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :test => :check_dependencies
task :default => :test
