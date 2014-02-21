require File.join(File.dirname(__FILE__), 'helper')

class DiffTest < MiniTest::Unit::TestCase
  class SuperGenerator < PrettyDiff::AbstractGenerator; def generate;end; end
  class UberGenerator < SuperGenerator; end

  class NotAGenerator; end

  def setup
    @diff = new_diff(fixture('first.diff'))
  end

  def test_chunks
    assert_equal 2, @diff.chunks.size
    @diff.chunks.each do |c|
      assert c.kind_of?(PrettyDiff::Chunk)
    end
  end

  def test_metadata
    assert_equal "--- Revision 1945\n+++ Revision 1995\n", @diff.metadata
  end

  def test_contents
    assert_equal 32, @diff.contents.lines.size
    assert_equal "@@ -8,6 +8,10 @@\n", @diff.contents.lines.first
    assert_equal "   }\n", @diff.contents.lines.last
  end

  def test_default_generator
    assert_equal 'PrettyDiff::BasicGenerator', new_diff('bla').generator.to_s
  end

  def test_custom_generator
    assert_equal 'DiffTest::SuperGenerator', new_diff('bla', :generator => SuperGenerator).generator.to_s
  end

  def test_invalid_custom_generator
    assert_raises PrettyDiff::InvalidGeneratorError do
      new_diff('bla', :generator => NotAGenerator)
    end

    assert new_diff('bla', :generator => UberGenerator)
  end

  def test_default_encoding
    assert_equal 'utf-8', new_diff('bla').out_encoding.downcase
  end

  def test_custom_encoding
    assert_equal 'cp1251', new_diff('bla', :out_encoding => 'cp1251').out_encoding
  end

  def test_encoding_cp1251_diff
    diff = new_diff(fixture('cp1251.diff'))
    assert_equal 1, diff.chunks.size
    assert diff.contents.include?('Сенат США')
  end

end
