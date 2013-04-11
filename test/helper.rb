require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'

require File.join(File.dirname(__FILE__), '..', 'lib', 'pretty_diff')

class MiniTest::Unit::TestCase

  def new_diff(*args)
    PrettyDiff::Diff.new(*args)
  end

  def fixture(name)
    File.read(File.join(File.dirname(__FILE__), "fixtures", name))
  end

end
