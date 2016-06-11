class Tree < ApplicationRecord
  belongs_to :root, class_name: 'Node', autosave: true

  before_validation :text_to_nodes!

  class ParseInfo < Struct.new(:parent_indent, :parent)
    def grandpa
      parent.parent_node
    end

    def to_s
      "(parent_indent, parent): (#{parent_indent}, #{parent.text})"
    end
  end

  def text_to_nodes!
    return if node_texts.empty?
    build_root(text: node_texts.first.text)
    node_texts.drop(1).reduce(ParseInfo.new(0, root)) do |info, node_text|
      if info.parent_indent < node_text.indent
        # ネストしてる
        ParseInfo.new(node_text.indent, info.parent.children.build(text: node_text.text))
      elsif info.parent_indent == node_text.indent
        # そのままつづく
        info.tap { |e| e.grandpa.children.build(text: node_text.text) }
      else
        # ネストが戻る
        ParseInfo.new(node_text.indent, info.grandpa.parent_node.children.build(text: node_text.text))
      end
    end
  end

  def node_texts
    @node_texts || node_texts!
  end

  def node_texts!
    @node_texts = raw_text.split("\n").map { |line| NodeText.new(line) }.reject(&:empty?)
  end
end
