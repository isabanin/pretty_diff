class PrettyDiff::ChunkGenerator
  
  attr_reader :chunk
  
  def initialize(chunk)
    @chunk = chunk
  end
  
  def generate
    start_html +
    chunk.line_numbers.to_html +
    code_html(content) +
    end_html
  end
  
private

  def content
    chunk.lines.map{|l| l.to_html }.join("\n")
  end

  def start_html
    %Q[<tr>]
  end
  
  def code_html(text)
    %Q[<td class="code"><div class="highlight"><pre>
#{text}</pre></div></td>]
  end
  
  def end_html
    %Q[</tr>]
  end
  
end