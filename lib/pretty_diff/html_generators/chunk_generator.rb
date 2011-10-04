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
  
  def wrapper_class
    klass = 'highlight'
    klass << ' chunk' if chunk.diff.chunks.size > 1
    klass
  end

  def start_html
    %Q[<div class="#{ wrapper_class }">]
  end

  def code_html(text)
    %Q[<div class="code-list"><pre>#{text}</pre></div>]
  end

  def end_html
    %Q[</div>]
  end

end
