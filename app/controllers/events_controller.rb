class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :switch_ready_status]

  def index
    # 今後のイベントのみ取得
    @feature_events = current_user.events.where(date: Date.today..Float::INFINITY).order(:date)
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
    if @event = Event.update(event_params)
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

  def set_event
    @event = Event.find(params[:id])
  end

end
