class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.active_relationships.create(followed_id: params[:id])
  end

  def destroy
    current_user.active_relationships.find_by(followed_id: params[:id]).destroy
  end

  def follow
    @followings = @user.followings
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
