require 'levenshtein'
require 'diff_match_patch_native'

module PrettyDiff
  module WordDiffFinder
    WDIFF_INSERTED_START = "\x01"
    WDIFF_INSERTED_END   = "\x02"
    WDIFF_DELETED_START  = "\x03"
    WDIFF_DELETED_END    = "\x04"

    extend self

    def find_word_diffs(lines)
      dmp = DiffMatchPatch.new
      result = []
      added_next_line_already = false

      lines.each_with_index do |line, idx|
        if added_next_line_already
          added_next_line_already = false
          next
        end

        previous_line = idx > 0 ? lines[idx - 1] : nil
        stripped_line = strip(line)
        next_line = lines[idx + 1]
        stripped_next_line = strip(next_line || '')
        after_next_line = idx < lines.size ? lines[idx + 2] : nil

        # only show word diffing when change was a single line
        if changed_line?(line, next_line) && !changed_block?(previous_line, line, next_line, after_next_line) && similiar_lines?(stripped_line, stripped_next_line)
          diffs = dmp.diff_cleanup_semantic!(dmp.diff_main(stripped_line, stripped_next_line, true))
          replacement, next_replacement = join_diffs(diffs)

          if line.include?(replacement.first)
            # String#gsub in the form gsub(exp,replacement) has odd quirks
            # affecting the replacement string which sometimes require
            # lots of escaping slashes. Ruby users are frequently directed
            # to use the block form instead.
            # See: http://stackoverflow.com/a/13818467/204927
            line.gsub!(replacement.first) { replacement.last }
          else # it has to come form next_line
            next_line.gsub!(replacement.first) { replacement.last }
            added_next_line_already = true
          end

          if next_line && next_replacement
            next_line.gsub!(next_replacement.first) { next_replacement.last }
            added_next_line_already = true
          end
        end

        result << line

        if added_next_line_already
          result << next_line
        end
      end

      result
    end

  private

    def to_utf8(str)
      str.force_encoding('utf-8')
    end

    def wrap_in_inserted_tokens(str)
      "#{WDIFF_INSERTED_START}#{str}#{WDIFF_INSERTED_END}"
    end

    def wrap_in_deleted_tokens(str)
      "#{WDIFF_DELETED_START}#{str}#{WDIFF_DELETED_END}"
    end

    def join_diffs(diffs)
      inserted, deleted = '', ''
      inserted_with_token, deleted_with_token = '', ''

      operations = diffs.map(&:first)
      # inline change
      if ( operations.include?(1) && !operations.include?(-1) ) || ( operations.include?(-1) && !operations.include?(1) )
        diffs.each do |diff|
          deleted += diff.last
          if diff.first == 0 # didn't change
            deleted_with_token += diff.last
          elsif diff.first == 1 # inserted
            deleted_with_token += wrap_in_inserted_tokens(diff.last)
          elsif diff.first == -1 # deleted
            deleted_with_token += wrap_in_deleted_tokens(diff.last)
          end
        end
      else
        diffs.each do |diff|
          if diff.first == 0 # didn't change
            inserted += diff.last
            deleted  += diff.last
            inserted_with_token += diff.last
            deleted_with_token  += diff.last
          elsif diff.first == 1  # inserted
            inserted += diff.last
            inserted_with_token += wrap_in_inserted_tokens(diff.last)
          elsif diff.first == -1 # deleted
            deleted += diff.last
            deleted_with_token += wrap_in_deleted_tokens(diff.last)
          end
        end
      end

      [[to_utf8(deleted), to_utf8(deleted_with_token)], [to_utf8(inserted), to_utf8(inserted_with_token)]]
    end

    def strip(line)
      line[1..-1]
    end

    def changed_line?(line, next_line)
      (line =~ /^-/ && next_line =~ /^\+/)
    end

    def changed_block?(previous_line, line, next_line, after_next_line)
      (previous_line =~ /^-/ && line =~ /^-/ && next_line =~ /^\+/ && after_next_line =~ /^\+/)
    end

    def similiar_lines?(first, second)
      Levenshtein.distance(first, second) <= [first.size, second.size].max * 0.60
    end
  end
end
