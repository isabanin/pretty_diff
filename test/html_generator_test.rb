require File.dirname(__FILE__) + '/helper'

class HtmlGeneratorTest < Test::Unit::TestCase
  
  context "Html Generator" do

    context "for lines" do      
      should "generate correct HTML for added line" do
        text = "+package chiro.methods.new.ones;"
        expected_html = %Q[<span class="gi">#{text}</span>]
        assert_equal expected_html, line_to_html(text)      
      end
    
      should "generate correct HTML for deleted line" do
        text = '-			browser.setTimeout("50000");'
        expected_html = %Q[<span class="gd">-      browser.setTimeout("50000");</span>]
        assert_equal expected_html, line_to_html(text)      
      end
    
      should "generate correct HTML for not modified line" do
        text = ' 	public static void close() {'
        expected_html = "   public static void close() {"
        assert_equal expected_html, line_to_html(text)
      end      
    end
    
  end
  
private

  def new_line(text)
    PrettyDiff::Line.new(text)
  end

  def line_to_html(text)
    new_line(text).to_html
  end
  
end