class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @presents = @user.presents
  end

  def edit
  end

  def update
  end

  def favorites
    favorites = @user.favorites.order(created_at: 'desc').pluck(:present_id)
    @presents = Present.find(favorites)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
