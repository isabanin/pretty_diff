class PrettyDiff::Diff
  CHUNK_REGEXP = /@@ .+ @@\n/

  attr_reader :input

  def initialize(unified_diff)
    @input = unified_diff
  end

  def to_html    
    PrettyDiff::HtmlGenerator.generate_diff(chunks)
  end

private

  def chunks
    @_chunks ||= find_chunks(input)
  end

  def find_chunks(text)
    meta_info = text.scan(CHUNK_REGEXP)
    returning(chunks = []) do
      split = text.split(CHUNK_REGEXP)
      split.shift
      split.each_with_index do |lines, idx|        
        chunks << PrettyDiff::Chunk.new(meta_info[idx], lines)
      end
    end
  end

end