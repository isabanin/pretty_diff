module PrettyDiff
  class Chunk
    attr_reader :diff, :meta_info, :lines, :contents

    def initialize(diff, meta_info, contents)
      @diff = diff
      @meta_info = meta_info
      @contents = contents
      @lines = find_lines
    end

    def line_numbers
      @_line_numbers ||= LineNumbers.new(diff, meta_info)
    end

  private

    def wdiff(lines)
      PrettyDiff::WordDiffFinder.find_word_diffs(lines)

    rescue StandardError
      # Screw per-word diffing, let's at least render the diff.
      lines  
    end

    def find_lines
      [].tap do |lines|
        plain_lines = contents.split(/\r?\n|\r/)
        wdiff(contents.split(/\r?\n|\r/)).each_with_index do |line_str, idx|
          begin
            line_str =~ //
          rescue ArgumentError
            line_str = plain_lines[idx]
          end

          line = Line.new(self, line_str)
          next if line.ignored?
          lines << line
          line_numbers.act_on_line(line)
          line.left_number = line_numbers.left_column.last
          line.right_number = line_numbers.right_column.last
        end
      end
    end

  end
end
