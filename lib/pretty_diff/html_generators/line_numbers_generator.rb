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
    insert_anchors(line_numbers.left_column, :left).join("\n")
  end
  
  def right_column
    insert_anchors(line_numbers.right_column, :right).join("\n")
  end

  def insert_anchors(array, align)
    returning(result = []) do
      array.each_with_index do |num, idx|
        if num.nil?
          result << ''
        else
          result << anchor_html(idx, num, align)
        end
      end
    end
  end
  
  def anchor_html(idx, num, align)
    %Q{<a href="#" id="#{line_numbers.name(idx, align)}">#{num}</a>}
  end
  
  def column_html(text)
    %Q[<td class="linenos"><pre>
#{text}</pre></td>]
  end
  
end