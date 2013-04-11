#
# Represent a single piece of a diff.
#
class PrettyDiff::Chunk #:nodoc:
  attr_reader :diff, :meta_info, :lines, :contents

  def initialize(diff, meta_info, contents)
    @diff = diff
    @meta_info = meta_info
    @contents = enforce_encoding(contents)
    @lines = find_lines
  end

  # Return LineNumbers object that represents two columns of numbers
  # that will be displayed on the left of the HTML presentation.
  def line_numbers
    @_line_numbers ||= PrettyDiff::LineNumbers.new(diff, meta_info)
  end

private

  def find_lines
    [].tap do |lines|
      contents.split(/\r?\n|\r/).each do |line_str|
        line = PrettyDiff::Line.new(diff, line_str)
        next if line.ignore?
        lines << line
        line_numbers.act_on_line(line)
      end
    end
  end

  def enforce_encoding(text, out_encoding=diff.options[:out_encoding])
    result = text
    if (encoding = detect_encoding(result)) && encoding != out_encoding
      result = convert_encoding(result, encoding, out_encoding)
    end
    if RUBY_VERSION >= "2.0.0"
      result.force_encoding(out_encoding)
    else
      result
    end
  end

  def detect_encoding(str)
    if detected = CharlockHolmes::EncodingDetector.detect(str)
      detected[:encoding]
    end
  end

  def convert_encoding(str, from, to)
    CharlockHolmes::Converter.convert(str, from, to)
  end

end
