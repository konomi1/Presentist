class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
  end

  def destroy
  end

  # jsで切り替えるならどちらか一つのアクションで良さそう？
  def followings
    @followings = @user.followings
  end

  def followers
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end