class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, except: [:index, :create]

  def index
    @friend = Friend.new
    # カナ降順順に並び替え
    @friends = current_user.friends.order(kana_name: "asc")
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

  def show
    @presents = @friend.presents
    @events = @friend.events
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
  end

  def ensure_current_user
    @friend = Friend.find(params[:id])
    unless @friend.user_id == current_user.id
      redirect_to user_path(current_user), notice: "登録したご本人以外はアクセスできません。"
    end
  end

end
