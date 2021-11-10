class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: [:edit, :update, :destroy]

  def index
    @friend = Friend.new
    @friends = current_user.friends.all
  end

  def create
    @friend = Friend.new(friend_params)
    @friend.user_id = current_user.id
    if @friend.save
      redirect_to friends_path, notice: "新しいフレンドが登録されました"
    else
      @friends = Friend.all
      render :index
    end
  end

  def edit
  end

  def update
    if @friend.update(friend_params)
      redirect_to friends_path
    else
      render :edit
    end
  end

  def destroy
    @friend.destroy
    redirect_to friends_path, notice: "フレンドを削除しました"
  end

  private

  def friend_params
    params.require(:friend).permit(:name, :kana_name, :relation, :gender, :memo)
  end

  def set_friend
    @friend = Friend.find(params[:id])
  end

end
