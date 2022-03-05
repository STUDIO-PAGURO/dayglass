require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "#create" do
    before do
      @comment = FactoryBot.build(:comment)
    end

    it "コメントがあれば保存できる" do
      expect(@comment).to be_valid
    end

    it "コメントが空では保存できない" do
      @comment.text = ""
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Textを入力してください")
    end
  end
end