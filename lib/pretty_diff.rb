module PrettyDiff #:nodoc:
end

def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end

require_local 'pretty_diff/diff'
require_local 'pretty_diff/chunk'
require_local 'pretty_diff/line_numbers'
require_local 'pretty_diff/line'
require_local 'pretty_diff/abstract_generator'
