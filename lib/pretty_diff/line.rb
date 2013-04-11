#
# Represent a single line of the diff.
#
class PrettyDiff::Line #:nodoc:

  attr_reader :diff, :contents

  def initialize(diff, contents)
    @diff = diff
    @contents = contents
  end

  # Unified Diff sometimes emit a special line at the end of the file
  # that we should not display in the output.
  # Return true or false.
  def ignore?
    contents =~ /\\ No newline at end of file/
  end

  # Return status of the Line. Can be :added, :deleted or :not_modified.
  def status
    case contents
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

end
