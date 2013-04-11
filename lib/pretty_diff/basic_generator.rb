module PrettyDiff
  class BasicGenerator < AbstractGenerator

    def generate
      content_tag :div, :class => 'diff' do
        diff.chunks.map{|c| ChunkGen[c].generate}.join('')
      end
    end

    class ChunkGen < PrettyDiff::AbstractGenerator
      def generate
        content_tag :div, :class => 'diff-chunk' do
          numbers + code
        end
      end

    private

      def numbers
        LineNumbersGen[chunk.line_numbers].generate
      end

      def code
        content_tag :div, :class => 'diff-code' do
          content_tag :pre do
            chunk.lines.map{|l| LineGen[l].generate }.join("\n")        
          end
        end
      end
    end

    class LineNumbersGen < PrettyDiff::AbstractGenerator
      def generate
        column(line_numbers.left_column) + column(line_numbers.right_column)
      end

    private

      def column(clmn)
        content_tag :div, :class => 'diff-line-nums' do
          content_tag :pre do
            fill_whitespace(clmn).join("\n")    
          end
        end
      end
      
      def fill_whitespace(numbers)
        [].tap do |filled|
          numbers.each do |v|
            filled << (v.nil? ? '&nbsp;' : v)
          end
        end
      end
    end

    class LineGen < PrettyDiff::AbstractGenerator
      def generate
        if line.added?
          content_tag(:span, :class => 'diff-line-add') do
            h(line.contents)
          end
        elsif line.deleted?
          content_tag(:span, :class => 'diff-line-del') do
            h(line.contents)
          end
        else
          h(line.contents)
        end
      end
    end
  end
end
