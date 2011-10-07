#
# Represent a single piece of a diff.
#
class PrettyDiff::Chunk #:nodoc:
  attr_reader :meta_info, :input, :lines

  def initialize(meta_info, input)
    @meta_info = meta_info
    @input = input
    collect_lines
  end

  # Generate HTML presentation for a Chunk. Return a string.
  def to_html(options = {})
    # We have to find lines before we can call line numbers methods.
    PrettyDiff::ChunkGenerator.generate(self, options)
  end

  # Return LineNumbers object that represents two columns of numbers
  # that will be displayed on the left of the HTML presentation.
  #
  # IMPORTANT! Before calling this method it's essential to call "find_lines!" first,
  # otherwise the array will be empty.
  def line_numbers
    @_line_numbers ||= PrettyDiff::LineNumbers.new(meta_info)
  end

private

  # Parse the input searching for lines. Initialize Line object for every line.
  # Return an array of Line objects.
  def collect_lines
    @lines = []
    @lines.tap do
      @input.split(/\r?\n/).each do |line_str|
        line = PrettyDiff::Line.new(line_str)
        next if line.ignore?
        @lines << line
        line_numbers.act_on_line(line)
      end
    end
  end

end
