class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    posts = Post.includes(:user).order("created_at DESC")
    user = User.find(current_user.id)
    followings = user.following_user
    @timeline = posts.where(user_id: followings).or(posts.where(user_id: user)).order("created_at DESC")
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
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
    @like = Like.new
  end

  def search
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
