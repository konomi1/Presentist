class PresentsController < ApplicationController
  before_action :authenticate_user!, except: [:ranking]
  before_action :set_present, only: [:show, :edit, :update, :destroy, :switch_return_status]

  def index
    @presents = Present.order(created_at: 'desc')
  end

  def show
  end

  def new
    @present = Present.new
  end

  def create
    @present = Present.new(present_params)
    @present.user_id = current_user.id
    if @present.save
      redirect_to presents_path, notice: "新しい贈り物ログが登録されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def ranking
  end

  def switch_return_status
  end

  private

  def present_params
    params.require(:present).permit(:friend_id, :gift_status, :age, :item, :price, :item_image, :scene_status, :memo, :return_status)
  end

  def set_present
    @present = Present.find(params[:id])
  end

end
