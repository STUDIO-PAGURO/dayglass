class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update]

  def index
    posts = Post.includes(:user)
    user = User.find(current_user.id)
    followings = user.following_user
    @recommendation_users = User.where.not(id: current_user.id).where.not(id: followings).order("RAND()").limit(5)
    @timeline = posts.where(user_id: followings, created_at: 24.hours.ago..).or(posts.where(user_id: user, created_at: 24.hours.ago..)).order("created_at DESC")
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def edit
    unless @post.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def show
    if @post.user_id != current_user.id && @post.created_at < 24.hours.ago
      redirect_to root_path
    end
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @like = Like.new
  end

  def search
    user = current_user
    followings = user.following_user
    @recommendation_users = User.where.not(id: current_user.id).where.not(id: followings).order("RAND()").limit(5)
    @posts = SearchService.search(params[:keyword])
  end

  private

  def post_params
    params.require(:post).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
