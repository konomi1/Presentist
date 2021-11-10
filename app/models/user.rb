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

  validates :name, presence: true
  validates :email, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :introduce, length: { maximum: 300 }

  enum gender: {male: 0, female:1 }

  attachment :image
end
