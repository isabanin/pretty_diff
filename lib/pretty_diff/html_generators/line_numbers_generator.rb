class PrettyDiff::LineNumbersGenerator

  attr_reader :line_numbers

  def initialize(line_numbers)
    @line_numbers = line_numbers
  end

  def generate
    column_html(left_column) + column_html(right_column) + column_html(middle_column, "code-indicators")
  end

private

  def left_column
    empty_lines_to_whitespace(line_numbers.left_column).join("\n")
  end

  def right_column
    empty_lines_to_whitespace(line_numbers.right_column).join("\n")
  end

  def middle_column
    line_numbers.middle_column.join("\n")
  end
  
  def empty_lines_to_whitespace(numbers)
    result = []
    numbers.each do |v|
      result << (v.nil? ? '&nbsp;' : v)
    end
    result
  end

  def column_html(text, class_name = "code-lines")
    %Q[<div class="#{class_name}"><pre>#{text}</pre></div>]
  end

end
