class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :presents, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 会員がフォローしている人
  has_many :followings, through: :active_relationships, source: :followed
  # 会員をフォローしている人
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :introduce, length: { maximum: 300 }

  enum gender: { male: 0, female: 1 }

  attachment :image

  # フォローしているか確認(フォローボタンで活用)
  def following?(user)
    followings.include?(user)
  end
end
