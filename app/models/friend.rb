class Friend < ApplicationRecord

  belongs_to :user
  has_many :presents, dependent: :destroy

  validates :name, presence: true
  validates :kana_name, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :memo, length: { maximum: 300 }

  # 相手との関係性
  enum relation: {
    friends: 0,
    steady: 1,
    spouse: 2,
    dad_and_mom: 3,
    children: 4,
    siblings: 5,
    grandparents: 6,
    rekative: 7,
    superior: 8,
    colleague: 9,
    junior: 10,
    customer: 11,
    coworker: 12,
    others: 13
  }

  enum gender: { male: 0, female: 1}
end
