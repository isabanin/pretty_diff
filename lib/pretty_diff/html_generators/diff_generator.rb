class PrettyDiff::DiffGenerator

  attr_reader :diff

  def initialize(diff)
    @diff = diff
  end

  def generate
    chunks_html = diff.chunks.map{|c| c.to_html}.join(chunk_separator_html).to_s
    intro_html + chunks_html + outro_html
  end

private

  def intro_html
    %Q[<table class="highlighttable">]
  end

  def chunk_separator_html
    %Q[<tr class="chunk_separator"><td colspan="3"></td></tr>]
  end

  def outro_html
    %Q[</table>]
  end

end
