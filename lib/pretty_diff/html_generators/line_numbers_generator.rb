class PrettyDiff::LineNumbersGenerator

  class << self

    def generate(line_numbers, options = {})
      class_name = options[:class_name] || 'code-lines'
      columns = ["left_column", "right_column"].map do |column_name|
        numbers = line_numbers.send(column_name.to_sym)
        empty_lines_to_whitespace(numbers).join("\n")
      end
      html_columns = columns.map do |column|
        column_html(column, class_name)
      end
      html_columns.join
    end

    def empty_lines_to_whitespace(numbers)
      numbers.map do |v|
        v.nil? ? '&nbsp;' : v
      end
    end

    def column_html(text, class_name)
      %Q[<div class="#{class_name}"><pre>#{text}</pre></div>]
    end

  end

end
