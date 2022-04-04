# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @following_users = @user.followings
    @follower_users = @user.followers
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings.order('follows.id DESC').page(params[:page])
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.order('follows.id DESC').page(params[:page])
  end
end
