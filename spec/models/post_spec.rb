require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#create" do
    before do
      @post = FactoryBot.build(:post)
    end

    it "textかimageが存在していれば保存できる" do
      expect(@post).to be_valid
    end

    it "textが空でも保存できる" do
      @post.text = ""
      expect(@post).to be_valid
    end

    it "imageが空でも保存できる" do
      @post.image = nil
      expect(@post).to be_valid
    end

    it "textとimageが空では保存できない" do
      @post.text = ""
      @post.image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("テキストを入力してください")
    end
  end
end
