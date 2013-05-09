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
module PrettyDiff
  class Diff
    CHUNK_REGEXP = /^@@ .+ @@\n?$?/

    attr_reader :unified_diff, :generator, :out_encoding

    #
    # Create new Diff object.
    # Accept a String in unified diff format and options hash.
    # Currrent options:
    # * generator -- your own custom implementation of HTML generator. Will use BasicGenerator by default.
    # * out_encoding -- convert encoding of diffs to the specififed encoding. utf-8 by default.
    #
    def initialize(unified_diff, options={})
      @unified_diff = unified_diff
      @options = options
      @out_encoding = 
      @generator = validate_generator(options[:generator]) || BasicGenerator
      @out_encoding = options[:out_encoding] || 'utf-8'
    end

    def metadata
      @_metadata ||= begin
        ''.tap do |result|
          unified_diff.each_line do |l|
            result << l
            break if l =~ /^\+\+\+ /
          end
        end
      end
    end

    def contents
      # We have to strip metadata from the rest of the diff
      # to enforce encoding. It's not uncommon for metadata to be in Unicode
      # while the diff itself is in some other encoding.
      @_contents ||= enforce_encoding(unified_diff.lines[metadata.lines.size..-1].join(''))
    end

    def to_html
      generator.new(self).generate
    end

    def chunks
      @_chunks ||= find_chunks
    end

  private

    def find_chunks
      chunks_meta = contents.scan(CHUNK_REGEXP)
      [].tap do |chunks|
        split = contents.split(CHUNK_REGEXP)
        split.shift
        split.each_with_index do |lines, idx|
          chunks << Chunk.new(self, chunks_meta[idx], lines)
        end
      end
    end

    def validate_generator(gen)
      return if gen.nil?

      if valid_generator?(gen)
        gen
      else
        raise InvalidGenerator, "#{gen.inspect} is not a valid PrettyDiff generator"
      end
    end

    def valid_generator?(gen)
      gen != nil &&
      gen.kind_of?(Class) &&
      gen.superclass == AbstractGenerator &&
      gen.instance_methods.include?(:generate)
    end

    def enforce_encoding(text)
      Encoding.enforce(out_encoding, text)
    end

  end
end
