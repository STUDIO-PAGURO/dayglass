class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comments = @post.comments.includes(:user)
    if @comment.save
      redirect_to post_path(@post)
    else
      @error_comment = @comment
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
