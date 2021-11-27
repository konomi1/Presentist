class Present < ApplicationRecord
  belongs_to :user
  belongs_to :friend
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :age, presence: true
  validates :item, presence: true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates :memo, length: { maximum: 300 }

  attachment :item_image

  # 年代
  enum age: {
    baby: 0,
    under_teens: 1,
    teens: 2,
    twenties: 3,
    thirties: 4,
    fourties: 5,
    fifties: 6,
    sixties: 7,
    seventies_and_over: 8,
  }
  # 送受ステータス
  enum gift_status: { give: 0, receive: 1 }
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
    others: 10,
  }
  # お返しの状態
  enum return_status: { unnecessary: 0, preparation: 1, done: 2 }

  # お返しステータスボタンを変更するメソッド
  def switch_return_status!
    if preparation?
      done!
    elsif done?
      preparation!
    else
      unnecessary!
    end
  end

  # お気に入りされているか確認
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # タイトルと内容で検索。
  def self.search_for(content)
    where("(item LIKE ?) OR (memo LIKE ?)", '%' + content + '%', '%' + content + '%')
  end
end
