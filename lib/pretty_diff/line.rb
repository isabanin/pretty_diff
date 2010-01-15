class PrettyDiff::Line    
  attr_reader :input
  
  def initialize(input)
    @input = input
  end
  
  def to_html
    PrettyDiff::HtmlGenerator.generate_line(self)
  end
  
  def status
    case input
    when /^\+/
      :added
    when /^\-/
      :deleted
    else
      :not_modified
    end
  end
  
  def rendered
    input.gsub("\t", '  ')
  end
  
  def ignore?
    input =~ /\\ No newline at end of file/
  end
  
  def added?
    status == :added
  end
  
  def deleted?
    status == :deleted
  end
  
  def not_modified?
    status == :not_modified
  end
end