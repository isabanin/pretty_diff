class PrettyDiff::LineGenerator

  attr_reader :line

  def initialize(line)
    @line = line
  end

  def generate
    if line.added?
      added_html(content)
    elsif line.deleted?
      deleted_html(content)
    else
      not_modified_html(content)
    end
  end

private

  def content
    @_content ||= line.format
  end

  def wrapper_html
    if line.diff.options[:wrap_lines]
      "<div> #{yield} </div>"
    else
      yield
    end
  end

  def added_html(text)
    wrapper_html { %Q[<span class="gi">#{text}</span>] }
  end

  def deleted_html(text)
    wrapper_html { %Q[<span class="gd">#{text}</span>] }
  end

  def not_modified_html(text)
    wrapper_html { %Q[#{text}] }
  end

end
