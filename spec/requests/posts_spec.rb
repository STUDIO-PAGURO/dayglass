require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe "GET #index" do
    context "未ログインの場合ログインページにリダイレクトされる" do
      it "302が返ってくる" do
        get root_path
        expect(response.status).to eq 302
      end

      it "indexアクションを行うとサインインページに遷移する" do
        get root_path
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "indexアクションにリクエストする" do
      before do
        @post = FactoryBot.create(:post)
        sign_in @post.user
      end
      
      it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
        get root_path
        expect(response.status).to eq 200
      end

      it "indexアクションにリクエストするとレスポンスに投稿済みのテキストが存在する" do
        get root_path
        expect(response.body).to include(@post.text)
      end
    end
  end
end