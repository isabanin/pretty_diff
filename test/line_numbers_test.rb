require File.join(File.dirname(__FILE__), 'helper')

class LineNumbersTest < MiniTest::Unit::TestCase

  def setup
    @diff = new_diff(fixture('first.diff'))
    @numbers = @diff.chunks.last.line_numbers
  end

  def test_left_column
    assert_equal [59, 60, 61, 62, nil, nil, nil, nil, nil, nil, 63, 64, 65, 66, 67, nil, nil, 68, 69, 70],
      @numbers.left_column
  end

  def test_right_column
    assert_equal [63, 64, 65, nil, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, nil, 76, 77, 78, 79, 80],
      @numbers.right_column
  end

end
