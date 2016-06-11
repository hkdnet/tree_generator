class NodeText
  include ActiveModel::Model

  attr_accessor :text

  def initialize(line)
    @text = line.sub(/\s+\Z/, '')
  end

  def indent
    m = @text.match(/\A(\s+)/)
    m ? m[1].size : 0
  end

  def empty?
    @text.empty?
  end
end
