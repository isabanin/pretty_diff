require File.join(File.dirname(__FILE__), 'helper')

class AbstractGeneratorTest < MiniTest::Unit::TestCase

  def setup
    @diff = new_diff(fixture('first.diff'))
  end

  def test_target_accessor
    generator = gen.new(@diff)
    assert generator.respond_to?(:diff)
    assert generator.instance_variables.include?(:diff)
  end

  def test_stubbed_generate
    assert_raises RuntimeError do
      gen.new(@diff).generate
    end
  end

  def test_tag_with_options
    assert_equal '<img class="test" />',
      gen.new(@diff).send(:tag, :img, :class => 'test')
  end

  def test_tag_without_options
    assert_equal '<img />',
      gen.new(@diff).send(:tag, :img)
  end

  def test_open_tag
    assert_equal '<strong>',
      gen.new(@diff).send(:tag, :strong, nil, true)
  end

  def test_content_tag_with_options
    assert_equal '<div class="test">a</div>',
      gen.new(@diff).send(:content_tag, :div, :class => 'test'){'a'}
  end

  def test_content_tag_without_options
    assert_equal '<div>a</div>',
      gen.new(@diff).send(:content_tag, :div){'a'}
  end

  def test_h
    assert_equal '&lt;strong&gt;vasya&lt;/strong&gt;',
      gen.new(@diff).send(:h, '<strong>vasya</strong>')
  end

  def test_class_to_target_name
    assert_equal 'diff',
      gen.new(@diff).send(:class_to_target_name, 'DiffGenerator') 

    assert_equal 'line_numbers',
      gen.new(@diff).send(:class_to_target_name, 'LineNumbersGen') 
  end

private

  def gen
    PrettyDiff::AbstractGenerator
  end

end
