class LikesController < ApplicationController
  before_action :post_params

  def create
    like = current_user.likes.new(post_id: @post.id)
    like.save
  end

  def destroy
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end

  private

  def post_params
    @post = Post.find(params[:post_id])
  end
end
