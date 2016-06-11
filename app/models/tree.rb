class Tree < ApplicationRecord
  belongs_to :root, class_name: 'Node', autosave: true

  before_validation :text_to_nodes!

  class ParseInfo < Struct.new(:parent_indent, :parent)
    def to_s
      "(parent_indent, parent): (#{parent_indent}, #{parent.text})"
    end
  end

  def text_to_nodes!
    build_root
    return if node_texts.empty?
    root.text = node_texts.first.text
    node_texts.drop(1).reduce(ParseInfo.new(0, root)) do |info, node_text|
      if info.parent_indent < node_text.indent
        # ネストしてる
        n = info.parent.children.build(text: node_text.text)
        ParseInfo.new(node_text.indent, n)
      elsif info.parent_indent == node_text.indent
        # そのままつづく
        info.parent.parent_node.children.build(text: node_text.text)
        info
      else
        # ネストが戻る
        n = info.parent.parent_node.parent_node.children.build(text: node_text.text)
        ParseInfo.new(node_text.indent, n)
      end
    end
  end

  def node_texts
    @node_texts || node_texts!
  end

  def node_texts!
    @node_texts = raw_text.split("\n").map{ |line| NodeText.new(line) }.reject { |e| e.empty? }
  end
end
