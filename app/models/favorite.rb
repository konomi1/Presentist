class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :present

  validates_uniqueness_of :present_id, scope: :user_id

end
