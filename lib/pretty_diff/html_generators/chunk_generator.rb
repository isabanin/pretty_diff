class PrettyDiff::ChunkGenerator

  class << self
    def generate(chunk, options = {})
      wrapper_klass = options[:wrapper_class] || 'code-viewer'
      code_klass = options[:code_class] || 'code-list'
      chunk_klass = options[:chunk_class] || 'chunk'
      chunks_size = options[:size] || 1
      line_options = options[:line_options] || {}
      line_numbers_options = options[:line_numbers_options] || {}
      start_html(wrapper_klass, chunk_klass, chunks_size) +
      chunk.line_numbers.to_html(line_numbers_options) +
      code_html(content(chunk, line_options), code_klass) +
      end_html
    end

    def start_html(*options)
      %Q[<div class="#{ wrapper_class(*options) }">]
    end

    def code_html(text, code_class)
      %Q[<div class="#{code_class}"><pre>#{text}</pre></div>]
    end

    def end_html
      %Q[</div>]
    end

    def wrapper_class(main_klass, chunk_klass, size)
      klass = [main_klass]
      klass << chunk_klass if size > 1
      klass.join(' ')
    end

    def content(chunk, options = {})
      chunk.lines.map{|l| l.to_html(options) }.join("\n")
    end

  end

end
