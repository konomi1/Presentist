class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :present

  validates :comment, presence: true, length: { maximum: 300 }
end
