class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @profile = @user.profile
  end

  def edit

  end

  def update
    
  end
end