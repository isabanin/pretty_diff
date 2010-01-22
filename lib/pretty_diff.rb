module PrettyDiff #:nodoc:
end

def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end

require_local 'pretty_diff/support'
require_local 'pretty_diff/diff'
require_local 'pretty_diff/chunk'
require_local 'pretty_diff/line_numbers'
require_local 'pretty_diff/line'

require_local 'pretty_diff/html_generators/diff_generator'
require_local 'pretty_diff/html_generators/chunk_generator'
require_local 'pretty_diff/html_generators/line_generator'
require_local 'pretty_diff/html_generators/line_numbers_generator'