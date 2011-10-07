class PrettyDiff::LineGenerator

  class << self
    def generate(line, options = {})
      if options[:wrap_lines]
        div_class = case
          when line.added?
            "gi"
          when line.deleted?
            "gd"
        end
        line = line.format
        class_string = div_class ? %Q[ class="#{div_class}"] : ''
        "<div#{class_string}>#{line}</div>"
      else
        line.format
      end
    end

  end

end
