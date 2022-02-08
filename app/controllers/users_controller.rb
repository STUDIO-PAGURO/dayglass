class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @id = user.id
    @name = user.name
    @account = user.account
    @posts = user.posts.order("created_at DESC")
    @profile = user.profile
    @icon = user.icon
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :icon)
  end
end