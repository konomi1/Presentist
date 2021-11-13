class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :ensure_current_user, only: [:edit, :update]

  def show
    @presents = @user.presents
    @to_presents = @user.presents.where(gift_status: "0")
    @from_presents = @user.presents.where(gift_status: "1")
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  def favorites
    favorites = @user.favorites.order(created_at: 'desc').pluck(:present_id)
    @presents = Present.find(favorites)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user
    unless @user == current_user
      redirect_to user_path(current_user), notice: "ユーザーご本人のみアクセスできます。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduce, :image_id)
  end

end
