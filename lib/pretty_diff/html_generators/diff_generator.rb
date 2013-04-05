class PrettyDiff::DiffGenerator

  attr_reader :diff

  def initialize(diff)
    @diff = diff
  end

  def generate
    diff.chunks.map{|c| c.to_html}.join('')
  end

end
