require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'turn'

require File.join(File.dirname(__FILE__), '..', 'lib', 'pretty_diff')

class MiniTest::Unit::TestCase
  include PrettyDiff::WordDiffFinder

  class FixtureNotFoundError < StandardError; end

  def new_diff(*args)
    PrettyDiff::Diff.new(*args)
  end

  def fixture(name)
    path = File.join(File.dirname(__FILE__), "fixtures", name)
    if File.exist?(path)
      File.read(path)
    else
      raise FixtureNotFoundError.new("Fixture at path '#{path}' was not found")
    end
  end

  def strip_word_indicators(text)
    text
    .gsub(WDIFF_INSERTED_START, '')
    .gsub(WDIFF_INSERTED_END, '')
    .gsub(WDIFF_DELETED_START, '')
    .gsub(WDIFF_DELETED_END, '')
  end

end
