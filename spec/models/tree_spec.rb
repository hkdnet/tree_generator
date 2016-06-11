require 'rails_helper'

RSpec.describe Tree, type: :model do
  describe 'node_texts' do
    it '空行を抜くこと' do
      raw_text = <<-EOS
hoge

  fuga
      EOS
      t = Tree.new(raw_text: raw_text)
      node_texts = t.node_texts
      expect(node_texts.count).to eq(2)
      expect(node_texts[0].text).to eq("hoge")
      expect(node_texts[1].text).to eq("  fuga")
    end
  end

  describe 'text_to_nodes!' do
    it 'rootのみのraw_text' do
      raw_text = "hoge"
      t = Tree.new(raw_text: raw_text)
      expect(t.root).to be_nil
      t.text_to_nodes!
      expect(t.root).not_to be_nil
      expect(t.root.text).to eq("hoge")
    end

    it 'rootとその子のraw_text' do
      raw_text = <<-EOS
hoge
  fuga
      EOS
      t = Tree.new(raw_text: raw_text)
      t.text_to_nodes!
      root = t.root
      expect(root.text).to eq("hoge")
      expect(root.children[0].text).to eq("  fuga")
    end

    it 'rootとその子が2人のraw_text' do
      raw_text = <<-EOS
hoge
  fuga
  piyo
      EOS
      t = Tree.new(raw_text: raw_text)
      t.text_to_nodes!
      root = t.root
      expect(root.text).to eq("hoge")
      expect(root.children[0].text).to eq("  fuga")
      expect(root.children[1].text).to eq("  piyo")
    end

    it 'rootとその子孫が1つずつのraw_text' do
      raw_text = <<-EOS
hoge
  fuga
    piyo
      EOS
      t = Tree.new(raw_text: raw_text)
      t.text_to_nodes!
      root = t.root
      expect(root.text).to eq("hoge")
      expect(root.children[0].text).to eq("  fuga")
      expect(root.children[0].children[0].text).to eq("    piyo")
    end

    it 'rootとその子孫が1つずつでネストが戻るraw_text' do
      raw_text = <<-EOS
hoge
  fuga
    piyo
  poyo
      EOS
      t = Tree.new(raw_text: raw_text)
      t.text_to_nodes!
      root = t.root
      expect(root.text).to eq("hoge")
      expect(root.children[0].text).to eq("  fuga")
      expect(root.children[1].text).to eq("  poyo")
      expect(root.children[0].children[0].text).to eq("    piyo")
    end
  end

  describe 'before_validation' do
    it "rootを保存してくれる" do
      raw_text = "hoge"
      t = Tree.new(raw_text: raw_text)
      expect{ t.save! }.to change { Node.count }.by(1)
      expect(Node.last.text).to eq("hoge")
    end

    it "root以下も保存してくれる" do
      raw_text = <<-EOS
hoge
  fuga
      EOS
      t = Tree.new(raw_text: raw_text)
      expect{ t.save! }.to change { Node.count }.by(2)
    end
  end
end
