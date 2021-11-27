class FavoritesController < ApplicationController
  before_action :set_present

  def create
    current_user.favorites.create(present_id: @present.id)
  end

  def destroy
    current_user.favorites.find_by(present_id: @present.id).destroy
  end

  private

  def set_present
    @present = Present.find(params[:id])
  end
end
