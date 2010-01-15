module PrettyDiff::HtmlGenerator
  extend self
  
  def intro
    %Q[<table class="highlighttable">]
  end

  def chunk_start
    %Q[<tr>]
  end
  
  def line_numbers_column(text)
    %Q[<td class="linenos"><pre>
#{text}</pre></td>]
  end
  
  def code(text)
    %Q[<td class="code"><div class="highlight"><pre>
#{text}</pre></div></td>]
  end
  
  def added_line(text)
    %Q[<span class="gi">#{text}</span>]
  end

  def deleted_line(text)
    %Q[<span class="gd">#{text}</span>]
  end

  def not_modified_line(text)
    text
  end

  def chunk_end
    %Q[</tr>]
  end
  
  def chunk_separator
    %Q[<tr class="chunk_separator"><td colspan="3"></td></tr>]
  end
  
  def outro
    %Q[</table>]
  end
  
  def generate_diff(chunks)
    chunks_html = chunks.map{|c| c.to_html}.join(chunk_separator).to_s
    intro + chunks_html + outro
  end
  
  def generate_chunk(numbers, lines)
    lines_html = lines.map{|l| l.to_html }.join("\n")
    chunk_start +
    numbers.to_html +
    code(lines_html) +
    chunk_end
  end
  
  def generate_line_numbers(left, right)
    line_numbers_column(left.join("\n")) +
    line_numbers_column(right.join("\n"))
  end
  
  def generate_line(obj)
    content = obj.rendered
    if obj.added?
      added_line(content)
    elsif obj.deleted?
      deleted_line(content)
    else
      not_modified_line(content)
    end
  end
  
end