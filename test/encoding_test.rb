require File.join(File.dirname(__FILE__), 'helper')

class EncodingTest < MiniTest::Unit::TestCase

  def test_detect
    assert_equal 'windows-1251', enc.detect(fixture('windows-cp1251-lf'))
  end

  def test_convert_cp1251_to_utf8
    text = enc.convert(fixture('windows-cp1251-lf'), 'windows-1251', 'utf-8')
    assert text.include?('Сенат США')
  end

  def test_keep_utf8
    text = enc.convert('Вася молодец', 'utf-8', 'utf-8')
    assert_equal 'Вася молодец', text
  end

  if RUBY_VERSION >= '2.0.0'
    def test_force_encoding_on_ruby2
      text = enc.enforce('utf-8', fixture('windows-cp1251-lf'))
      assert_equal 'utf-8', text.encoding.to_s.downcase

      text = enc.enforce('windows-1251', fixture('windows-cp1251-lf'))
      assert_equal 'windows-1251', text.encoding.to_s.downcase
    end
  end

private

  def enc
    PrettyDiff::Encoding
  end

end
