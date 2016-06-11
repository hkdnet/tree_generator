require 'spec_helper'

RSpec.describe NodeText, type: :model do
  before do
    @line = ""
  end

  let(:node_text) { NodeText.new(@line) }

  it '末尾の空白が取り除かれる' do
    @line = "hoge "
    expect(node_text.text).to eq("hoge")
  end

  it '先頭の空白は取り除かれない' do
    @line = " hoge"
    expect(node_text.text).to eq(" hoge")
  end

  describe 'empty?' do
    it '空文字のときtrue' do
      @line = ""
      expect(node_text.empty?).to be_truthy
    end
  end

  let(:indent) { node_text.indent }
  describe 'indent' do
    it '空文字のときインデントゼロ' do
      expect(indent).to eq(0)
    end

    it '先頭に何もないときインデントゼロ' do
      @line = "hoge"
      expect(indent).to eq(0)
    end

    it '先頭に半角スペースが1つあるときインデント1' do
      @line = " hoge"
      expect(indent).to eq(1)
    end

    it '先頭にタブ文字が1つあるときインデント1' do
      @line = "\thoge"
      expect(indent).to eq(1)
    end

    it '先頭に半角スペースが2つあるときインデント1' do
      @line = "  hoge"
      expect(indent).to eq(2)
    end
  end
end
