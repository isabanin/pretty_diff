class PrettyDiff::Chunk    
  attr_reader :meta_info, :input
  
  def initialize(meta_info, input)
    @meta_info = meta_info
    @input = input
  end
  
  def to_html
    # We have to find lines before we can call line numbers methods.
    find_lines!
    PrettyDiff::HtmlGenerator.generate_chunk(line_numbers, lines)
  end
  
  def lines
    @lines
  end
  
  def line_numbers
    @_line_numbers ||= PrettyDiff::LineNumbers.new(meta_info)
  end
  
private

  def find_lines!
    returning(@lines = []) do
      input.split(/\r?\n/).each do |line_str|
        line = PrettyDiff::Line.new(line_str)
        next if line.ignore?
        @lines << line
        line_numbers.act_on_line(line)
      end
    end
  end

end