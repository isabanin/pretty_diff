require File.join(File.dirname(__FILE__), 'helper')

class BasicGeneratorTest < MiniTest::Unit::TestCase

  def test_generated_html
    diff = new_diff(fixture('first.diff'), :generator => PrettyDiff::BasicGenerator)
    File.open('/Users/ilya/Desktop/zopa', 'w'){|f| f << diff.to_html}
    assert_equal fixture('first.diff.html'), diff.to_html
  end

end
