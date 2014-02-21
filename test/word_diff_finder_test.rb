require File.join(File.dirname(__FILE__), 'helper')

class WordDiffFinderTest < MiniTest::Unit::TestCase
  def test_join_diff_from_dmp
    diffs = [[0, "    Object argsLength(args,length"], [1, "s"], [0, ") {\n"]]
    expected = "    Object argsLength(args,lengths) {\n"
    expected_with_token = "    Object argsLength(args,length#{wrap_in_inserted_tokens 's'}) {\n"
    assert_equal [expected, expected_with_token], join_diffs(diffs).first

    diffs = [[0, "              case \""], [-1, "%"], [1, "percent"], [0, "\":\n"]]
    expected_first = "              case \"%\":\n"
    expected_first_with_token = "              case \"#{wrap_in_deleted_tokens '%'}\":\n"

    expected_second = "              case \"percent\":\n"
    expected_second_with_token = "              case \"#{wrap_in_inserted_tokens 'percent'}\":\n"

    first, second = join_diffs(diffs)
    assert_equal [expected_first, expected_first_with_token], first
    assert_equal [expected_second, expected_second_with_token], second

    diffs = [[-1, "      "], [0, "\n"]]
    expected = "      \n"
    expected_with_token = "#{wrap_in_deleted_tokens '      '}\n"
    assert_equal [expected, expected_with_token], join_diffs(diffs).first
  end

  def test_highlighting_inline_diff
    content = fixture('inline_change.diff').lines
    lines_found = find_word_diffs(content)
    assert_equal content.size, lines_found.size

    # two inline delete highlighted
    assert 2, num_of_tags(WDIFF_DELETED_START, lines_found)
    # two inline insert highlighted
    assert 2, num_of_tags(WDIFF_INSERTED_START, lines_found)
  end

  def test_highlighting_quick_diff
    content = fixture('quick_change.diff').lines
    lines_found = find_word_diffs(content)
    assert_equal content.size, lines_found.size

    assert lines_include_wrapped_content(lines_found, wrap_in_inserted_tokens('test'))
    # one inline insert highlighted
    assert_equal 1, num_of_tags(WDIFF_INSERTED_START, lines_found)
  end

  def test_highlighting_single_space_diff
    content = fixture('space_change.diff').lines
    lines_found = find_word_diffs(content)
    assert_equal content.size, lines_found.size

    assert lines_include_wrapped_content(lines_found, "parsed#{wrap_in_inserted_tokens ' '}Width")
    # one inline insert highlighted
    assert_equal 1, num_of_tags(WDIFF_INSERTED_START, lines_found)
  end

  def test_highlighting_special_character_diff
    content = fixture('special_characters.diff').lines
    lines_found = find_word_diffs(content)
    assert_equal content.size, lines_found.size

    assert lines_include_wrapped_content(lines_found, wrap_in_inserted_tokens("s83line"))

    # one inline insert highlighted
    assert_equal 1, num_of_tags(WDIFF_INSERTED_START, lines_found)
    assert_equal 0, num_of_tags(WDIFF_DELETED_START, lines_found)
  end

  private

  def lines_include_wrapped_content(lines, content)
    lines.map(&:to_s).join("\n").include?(content)
  end

  def num_of_tags(tag, lines)
    lines.join("\n").scan(/#{tag}/).size
  end
end