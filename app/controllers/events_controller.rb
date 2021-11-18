class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, except: [:index, :new, :create]

  def index
    # 今後のイベントのみ取得
    @feature_events = current_user.events.where(date: Date.today..Float::INFINITY).order(:date)
    @events = current_user.events.order(date: 'desc').page(params[:page])
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def switch_ready_status
    @event.switch_ready_status!
    redirect_to request.referer, notice: "スイッチ完了"
  end

  private

  def event_params
    params.require(:event).permit(:friend_id, :date, :memo, :scene_status, :ready_status)
  end

  def ensure_current_user
    @event = Event.find(params[:id])
    unless @event.user_id == current_user.id
      redirect_to user_path(current_user), notice: "登録したご本人以外はアクセスできません。"
    end
  end
end
