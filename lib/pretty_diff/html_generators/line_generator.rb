class PrettyDiff::LineGenerator

  attr_reader :line

  def initialize(line)
    @line = line
  end

  def generate
    wrapper_html { content }
  end

private

  def content
    @_content ||= line.format
  end

  def wrapper_html
    if line.diff.options[:wrap_lines]
      div_class = case
        when line.added?
          "gi"
        when line.deleted?
          "gd"
        else
          ""
      end
      "<div class='#{div_class}'> #{yield} </div>"
    else
      yield
    end
  end

end
