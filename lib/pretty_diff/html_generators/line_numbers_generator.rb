class PrettyDiff::LineNumbersGenerator

  attr_reader :line_numbers

  def initialize(line_numbers)
    @line_numbers = line_numbers
  end

  def generate
    column_html(left_column) + column_html(right_column)
  end

private

  def left_column
    empty_lines_to_whitespace(line_numbers.left_column).join("\n")
  end

  def right_column
    empty_lines_to_whitespace(line_numbers.right_column).join("\n")
  end
  
  def empty_lines_to_whitespace(numbers)
    result = []
    numbers.each do |v|
      result << (v.nil? ? '&nbsp;' : v)
    end
    result
  end

  def column_html(text)
    %Q[<div class="code-lines"><pre>
#{text}
</pre></div>]
  end

end
