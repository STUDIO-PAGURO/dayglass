class RelationshipsController < ApplicationController
  before_action :set_user

  def follow
    current_user.follow(params[:id])
    render :create
  end

  def unfollow
    current_user.unfollow(params[:id])
    render :destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
