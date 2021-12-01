class PresentsController < ApplicationController
  before_action :authenticate_user!, except: [:ranking]
  before_action :set_present, only: [:show, :edit, :update, :destroy, :switch_return_status]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def index
    @presents = Present.order(created_at: :desc).page(params[:page])
    @to_presents = Present.where(gift_status: "1").order(created_at: :desc).page(params[:page])
    @from_presents = Present.where(gift_status: "0").order(created_at: :desc).page(params[:page])
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
      # Google-APIで画像にタグ生成
      tags = Vision.get_image_data(@present.item_image)
      tags.each do |tag|
        @present.tags.create(name: tag)
      end
      redirect_to presents_path, notice: "新しい贈り物ログが登録されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @present.update(present_params)
      redirect_to present_path, notice: "贈り物ログを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @present.destroy
    redirect_to presents_path, notice: "贈り物ログを削除しました"
  end

  def ranking
    @rankings = Present.find(Favorite.group(:present_id).order(Arel.sql("count(present_id) desc")).limit(3).pluck(:present_id))
    if user_signed_in?
      start_date = params.fetch(:date, Date.today).to_date
      @events = current_user.events.where(date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    end
  end

  def switch_return_status
    @present.switch_return_status!
    redirect_to request.referer
  end

  private

  def present_params
    params.require(:present).permit(
      :friend_id,
      :gift_status,
      :age,
      :item,
      :price,
      :item_image,
      :scene_status,
      :memo,
      :return_status
    )
  end

  def set_present
    @present = Present.find(params[:id])
  end

  def ensure_current_user
    unless @present.user_id == current_user.id
      redirect_to user_path(current_user), notice: "ログを登録したご本人以外はアクセスできません。"
    end
  end
end
