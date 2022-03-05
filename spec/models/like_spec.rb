require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "正常値と異常値の確認" do
    before do
      @like = FactoryBot.create(:like)
      sleep 0.1
    end

    context "likeモデルのバリデーション" do
      it "user_idとpost_idがあれば保存できる" do
        expect(@like).to be_valid
      end

      it "user_idがなければ無効な状態である" do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Userを入力してください")
      end

      it "post_idがなければ無効な状態である" do
        @like.post_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Postを入力してください")
      end

      it "post_idが同じでもuser_idが違うと保存できる" do
        @like.save
        another_like = FactoryBot.create(:like, post_id: @like.post_id)
        expect(another_like).to be_valid
      end

      it "user_idが同じでもpost_idが違うと保存できる" do
        @like.save
        another_user = FactoryBot.create(:like, user_id: @like.user_id)
        expect(another_user).to be_valid
      end
    end
  end
end
