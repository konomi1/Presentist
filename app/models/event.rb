class Event < ApplicationRecord

  belongs_to :user
  belongs_to :friend

  validates :date, presence: true
  validates :ready_status, presence: true
  validates :scene_status, presence: true

  # 贈り物の準備ステータス
  enum ready_status: { preparation: 0, ready: 1}
  # 贈り物の理由
  enum scene_status: {
    birthday: 0,
    anniversary: 1,
    summer_gift: 2,
    year_end_giht: 3,
    otosidama: 4,
    wedding: 5,
    newborn: 6,
    admission: 7,
    graduation: 8,
    incense: 9,
    others: 10
  }

  # 贈り物準備ステータスボタンをスイッチ
  def switch_ready_status!
    if preparation?
      ready!
    else
      preparation!
    end
  end

  # simple_calendar用メソッド
  def start_time
    self.date
  end

end
