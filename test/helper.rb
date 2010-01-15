require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'pretty_diff'

class Test::Unit::TestCase
  
  def read_diff(name)
    File.read(File.join(File.dirname(__FILE__), "data", name))
  end
  
end
