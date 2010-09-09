require File.dirname(__FILE__) + '/helper'

# 	<link rel="stylesheet" href="../stylesheets/codecolorer.css" type="text/css" media="screen, projection" />
# 	<link rel="stylesheet" href="../stylesheets/modalbox.css" type="text/css" media="screen, projection" />
# 	<link rel="stylesheet" href="../stylesheets/print.css" type="text/css" media="print" />
#+	<link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon" />
#+	<link rel="apple-touch-icon" href="../images/apple-touch-icon.png"/>
# 	<script type="text/javascript" src="../javascripts/prototype.js" charset="utf-8"></script>
# 	<script type="text/javascript" src="../javascripts/scriptaculous.js" charset="utf-8"></script>
# 	<script type="text/javascript" src="../javascripts/application.js" charset="utf-8"></script>

class ChunkTest < Test::Unit::TestCase
  context "Diff Chunk" do
    setup do
      @diff = PrettyDiff::Diff.new read_diff('second.diff')
      @chunk = @diff.send(:chunks).first
      @chunk.send(:find_lines!)
    end

    should "generate HTML without errors" do
      assert @chunk.to_html
    end

    should "find correct amount of left line numbers" do
      assert @chunk.send(:line_numbers).send(:left_column).compact.size == 6
    end

    should "find correct amount of right line numbers" do
      assert @chunk.send(:line_numbers).send(:right_column).compact.size == 8
    end

    should "find correct amount of lines" do
      assert @chunk.lines.size == 8
    end

  end
end
