require 'helper'

class BasicGeneratorTest < MiniTest::Unit::TestCase

  def test_generated_html
    diff = new_diff(fixture('first.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('first.diff.html'), strip_word_indicators(diff.to_html)
  end

  def test_more_generated_html
    diff = new_diff(fixture('text.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('text.diff.html'), strip_word_indicators(diff.to_html)
  end

  def test_another_generated_html
    diff = new_diff(fixture('csharp.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('csharp.diff.html'), strip_word_indicators(diff.to_html)
  end

  def test_generate_html_for_blank
    diff = new_diff(fixture('blank.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('blank.diff.html'), strip_word_indicators(diff.to_html)
  end

  def test_generate_html_for_single_line_diffs
    diff = new_diff(fixture('single_line.diff'), :generator => PrettyDiff::BasicGenerator)
    assert_equal fixture('single_line.diff.html'), strip_word_indicators(diff.to_html)
  end
end
