#
# Represent a single line of the diff.
#
class PrettyDiff::Line #:nodoc:
  
  attr_reader :input
  
  def initialize(input)
    @input = input
  end
  
  # Generate HTML presentation for a Line. Return a string.
  def to_html
    generator.generate
  end
  
  # Prepare Line contents for injection into HTML structure.
  # Currently used for replacing Tab symbols with spaces.
  # Return a string.
  def format
    input.gsub("\t", '  ')
  end
  
  # Unified Diff sometimes emit a special line at the end of the file
  # that we should not display in the output.
  # Return true or false.
  def ignore?
    input =~ /\\ No newline at end of file/
  end
  
  # Return status of the Line. Can be :added, :deleted or :not_modified.
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
  
  def added?
    status == :added
  end
  
  def deleted?
    status == :deleted
  end
  
  def not_modified?
    status == :not_modified
  end
  
private

  def generator
    @_generator ||= PrettyDiff::LineGenerator.new(self)
  end
  
end