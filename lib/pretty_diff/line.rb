module PrettyDiff
  class Line

    attr_reader :diff, :contents

    def initialize(diff, contents)
      @diff = diff
      @contents = contents
    end

    def ignored?
      contents =~ /\\ No newline at end of file/
    end

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
end
