require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

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
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
