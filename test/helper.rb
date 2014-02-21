require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'turn'

require File.join(File.dirname(__FILE__), '..', 'lib', 'pretty_diff')

class MiniTest::Unit::TestCase
  include PrettyDiff::WordDiffFinder

  def new_diff(*args)
    PrettyDiff::Diff.new(*args)
  end

  def fixture(name)
    File.read(File.join(File.dirname(__FILE__), "fixtures", name))
  end

  def strip_word_indicators(text)
    text
    .gsub(WDIFF_INSERTED_START, '')
    .gsub(WDIFF_INSERTED_END, '')
    .gsub(WDIFF_DELETED_START, '')
    .gsub(WDIFF_DELETED_END, '')
  end

end
