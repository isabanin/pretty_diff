require File.join(File.dirname(__FILE__), 'helper')

class ChunkTest < MiniTest::Unit::TestCase

  def setup
    @diff = new_diff(fixture('first.diff'))
    @chunk = @diff.chunks.last 
  end

  def test_lines
    assert_equal 20, @chunk.lines.size
    @chunk.lines.each do |l|
      assert l.kind_of?(PrettyDiff::Line)
    end
  end

  def test_line_numbers
    assert @chunk.line_numbers.kind_of?(PrettyDiff::LineNumbers)
  end
end
