class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC")
    @profile = @user.profile
  end

  def edit

  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :image)
  end
end