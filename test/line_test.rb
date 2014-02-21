require File.join(File.dirname(__FILE__), 'helper')

class LineTest < MiniTest::Unit::TestCase

  def setup
    @diff = new_diff(fixture('first.diff'))
    @lines = @diff.chunks.last.lines
  end

  def test_contents
    assert_equal "     color: #999;", strip_word_indicators(@lines[0].contents)
    assert_equal "-  table.account-overview td .status {", strip_word_indicators(@lines[3].contents)
    assert_equal "+  table.account-overview td.label.top {", strip_word_indicators(@lines[4].contents)
    assert_equal "   }", strip_word_indicators(@lines.last.contents)
  end

  def test_ignored
    line = PrettyDiff::Line.new(@diff, '\ No newline at end of file')
    assert line.ignored?
  end

  def test_status_added
    assert_equal :added, @lines[4].status
  end

  def test_status_deleted
    assert_equal :deleted, @lines[3].status
  end

  def test_status_not_modified
    assert_equal :not_modified, @lines[0].status
  end

end
