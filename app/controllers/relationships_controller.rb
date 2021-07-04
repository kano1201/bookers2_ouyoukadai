class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow!(@user)
    redirect_to @user
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followed_users
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end