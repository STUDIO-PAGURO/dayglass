require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できる時" do
      it "nameとaccountとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end

      it "passwordとpassword_confirmationが英字と数字両方含めて6文字以上あれば登録できる" do
        @user.password = "000aaa"
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end

    context "新規登録できない時" do
      it "nameが空では登録できない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it "accountが空では登録できない" do
        @user.account = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("アカウントを入力してください")
      end

      it "accountが英数字、@._-以外の文字を含んでいると登録できない" do
        @user.account = "ああああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("アカウントは不正な値です")
      end

      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "passwordが5文字以下であれば登録できない" do
        @user.password = "000aa"
        @user.password_confirmation = "000aa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it "passwordが英字と数字を両方含めてないと登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end

      it "passwordとpassword_confirmationが一致していなければ登録できない" do
        @user.password = "000aaa"
        @user.password_confirmation = "111bbb"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード(確認用)とパスワードの入力が一致しません")
      end

      it "パスワードが暗号化されている" do
        expect(@user.encrypted_password).to_not eq "password"
      end

      it "重複したaccountが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, account: @user.account)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("アカウントはすでに存在します")
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
    end
  end

  describe "フォローの検証" do
    it "ユーザーが他のユーザーをフォロー、フォロー解除可能である" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user1.follow(user2.id)
      expect(user1.following?(user2)).to eq true
      user1.unfollow(user2.id)
      expect(user1.following?(user2)).to eq false
    end

    it "フォロー中のユーザーが削除されると、フォローが解消される" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user1.follow(user2.id)
      expect(user1.following?(user2)).to eq true
      user1.destroy
      expect(user1.following?(user2)).to eq false
    end
  end
end