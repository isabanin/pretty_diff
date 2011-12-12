#
# Represent a single line of the diff.
#
class PrettyDiff::Line #:nodoc:

  INLINE_INSERT_START = /\{\+/
  INLINE_INSERT_END = /\+\}/
  INLINE_DELETE_START = /\[-/
  INLINE_DELETE_END = /-\]/

  attr_reader :diff, :input

  def initialize(diff, input)
    @diff = diff
    @input = input
  end

  # Generate HTML presentation for a Line. Return a string.
  def to_html
    generator.generate
  end

  # Prepare Line contents for injection into HTML structure.
  def format
    input.gsub(INLINE_INSERT_START, '<ins>') \
      .gsub(INLINE_INSERT_END, '</ins>') \
      .gsub(INLINE_DELETE_START, '<del>') \
      .gsub(INLINE_DELETE_END, '</del>') \
      .gsub("\t", '  ')
  end

  # Unified Diff sometimes emit a special line at the end of the file
  # that we should not display in the output.
  # Return true or false.
  def ignore?
    input =~ /\\ No newline at end of file/
  end

  # Return status of the Line. Can be :modified (for per-word diffing), :added, :deleted or :not_modified.
  def status
    case input
    when /(#{ INLINE_DELETE_START }|#{ INLINE_INSERT_START })/
      :modified
    when /^\+/
      :added
    when /^\-/
      :deleted
    else
      :not_modified
    end
  end

  def modified?
    status == :modified
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
