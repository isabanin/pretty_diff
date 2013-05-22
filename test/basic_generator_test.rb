require 'helper'

class BasicGeneratorTest < MiniTest::Unit::TestCase

  def test_generated_html
    diff = new_diff(fixture('first.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('first.diff.html'), diff.to_html
  end

  def test_more_generated_html
    diff = new_diff(fixture('text.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('text.diff.html'), diff.to_html
  end

  def test_another_generated_html
    diff = new_diff(fixture('csharp.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('csharp.diff.html'), diff.to_html
  end
end
