#
# Main class to interact with. In fact this is the only class you should interact with
# when using the library.
#
# === Usage example
#  pretty = PrettyDiff::Diff.new(udiff)
#  pretty.to_html
#
# Keep in mind that Diff will automatically escape all HTML tags from the intput string
# so that it doesn't interfere with the output.
#
class PrettyDiff::Diff
  CHUNK_REGEXP = /^@@ .+ @@\n?/

  attr_reader :unified_diff, :options

  # Create new Diff object.
  # Accept a String in unified diff format and options hash.
  # Currrent options:
  # * generator -- your own custom implementation of HTML generator. Will use AbstractGenerator by default.
  # * out_encoding -- convert encoding of diffs to the specififed encoding. utf-8 by default.
  def initialize(unified_diff, options={})
    @unified_diff = unified_diff
    @options = options
    options[:out_encoding] ||= 'utf-8'
  end

  # Generate HTML presentation. Return a string.
  def to_html
    generator.new(self).generate
  end

  # Return an array of Chunk objects that Diff found in the unified_diff.
  def chunks
    @_chunks ||= find_chunks(unified_diff)
  end

private

  def generator
    options[:generator] || AbstractGenerator
  end

  # Parse the unified_diff for diff chunks and initialize a Chunk object for each of them.
  # Return an array of Chunks.
  def find_chunks(text)
    meta_info = text.scan(CHUNK_REGEXP)
    chunks = []
    chunks.tap do
      split = text.split(CHUNK_REGEXP)
      split.shift
      split.each_with_index do |lines, idx|
        chunks << PrettyDiff::Chunk.new(self, meta_info[idx], lines)
      end
    end
  end

end
