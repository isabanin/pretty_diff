require File.dirname(__FILE__) + '/helper'

class LineTest < Test::Unit::TestCase
  context "PrettyDiff's Line" do

    should "indicate :added status correctly" do
      added_line = new_diff("+package chiro.methods.new.ones;")
      assert_equal :added, added_line.status
    end
    
    should "indicate :deleted status correctly" do
      deleted_line = new_diff('-browser.setTimeout("50000");')
      assert_equal :deleted, deleted_line.status
    end
    
    should "indicate :not_modified status correctly" do
      not_modified_line = new_diff("class User < ActiveRecord::Base")
      assert_equal :not_modified, not_modified_line.status
    end
    
    should "ignore trailing 'no newline' text" do
      text = '\ No newline at end of file'
      line = new_diff(text)
      assert line.ignore?
    end
  
    should "replace tabs with spaces" do
      text = "		hello eptut {1, 2, 3}"
      expected_output = "    hello eptut {1, 2, 3}"
      line = new_diff(text)
      assert_equal expected_output, line.rendered
    end
  
  end
  
private

  def new_diff(text)
    PrettyDiff::Line.new(text)
  end

  def line_to_html(text)
    new_diff(text).to_html
  end
end