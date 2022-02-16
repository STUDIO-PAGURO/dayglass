class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).order("RAND()")
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC")
    @followings = @user.following_user
    @followers = @user.follower_user
    @recommendation_users = User.where.not(id: current_user.id).order("RAND()").limit(5)
  end

  def edit
    user = User.find(params[:id])
    @icon = user.icon
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def following
    @user = User.find(params[:user_id])
    @followings = @user.following_user
    @followers = @user.follower_user
    @recommendation_users = User.where.not(id: current_user.id).order("RAND()").limit(5)
  end

  def follower
    @user = User.find(params[:user_id])
    @followers = @user.follower_user
    @followings = @user.following_user
    @recommendation_users = User.where.not(id: current_user.id).order("RAND()").limit(5)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :icon)
  end
end