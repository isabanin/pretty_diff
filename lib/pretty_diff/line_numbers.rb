module PrettyDiff
  class LineNumbers

    attr_reader :diff, :meta_info

    def initialize(diff, meta)
      @diff = diff
      @meta_info = meta
    end

    def act_on_line(line)
      if line.added?
        increase_right
      elsif line.deleted?
        increase_left
      else
        increase_both
      end
    end

    def left_column
      @left_column ||= []
    end

    def right_column
      @right_column ||= []
    end

  private

    def scan_meta(target)
      meta_info.scan(target).flatten.first
    end

    def left_starts_at
      scan_meta(/^@@ -(\d+)/).to_i
    end

    def right_starts_at
      scan_meta(/\+(\d+)(?:,\d+)? @@/).to_i
    end

    def increase_left
      left_column  << increase_or_start(:left)
      right_column << nil
    end

    def increase_right
      left_column  << nil
      right_column << increase_or_start(:right)
    end

    def increase_both
      left_column  << increase_or_start(:left)
      right_column << increase_or_start(:right)
    end

    def increase_or_start(which)
      previous = send("#{which}_column").reverse.find{|e| !e.nil?}
      if previous then previous + 1 else send("#{which}_starts_at") end
    end

  end
end
