class PrettyDiff::DiffGenerator

  class << self

    def generate(diff, options = {})
      size = diff.chunks.size
      chunks_html = diff.chunks.map do |chunk|
        chunk.to_html(options.merge(:size => size))
      end.join(chunk_separator_html).to_s
      intro_html + chunks_html + outro_html
    end

    def intro_html
      %Q[]
    end

    def chunk_separator_html
      %Q[]
    end

    def outro_html
      %Q[]
    end
  end

end
