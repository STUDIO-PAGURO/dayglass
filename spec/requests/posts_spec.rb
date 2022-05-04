require 'rails_helper'

RSpec.describe PostsController, type: :request do

  before do
    @post = FactoryBot.create(:post)
  end

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

    context "ログインしてindexアクションにリクエストする" do
      before do
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

      it "indexアクションにリクエストするとレスポンスに24時間以内に投稿済みのテキストが存在する" do
        get root_path
        expect(response.body).to include(@post.text)
      end
    end
  end

  describe "GET #show" do
    context "未ログインの場合ログインページにリダイレクトされる" do
      it "302が返ってくる" do
        get post_path(@post)
        expect(response.status).to eq 302
      end

      it "indexアクションを行うとサインインページに遷移する" do
        get post_path(@post)
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context "ログインしてshowアクションにリクエストする" do
      before do
        sign_in @post.user
      end

      it "showアクションにリクエストすると正常にレスポンスが返ってくる" do
        get post_path(@post)
        expect(response.status).to eq 200
      end

      it "showアクションにリクエストするとレスポンスに投稿済みのテキストが存在する" do
        get post_path(@post)
        expect(response.body).to include(@post.text)
      end

      it "showアクションにリクエストするとレスポンスに投稿済みの画像が存在する" do
        get post_path(@post)
        expect(response.body).to include("post-image")
      end

      it "showアクションにリクエストするとレスポンスにコメント投稿部分が存在する" do
        get post_path(@post)
        expect(response.body).to include("コメントする")
      end
    end
  end
end