FactoryBot.define do
  factory :relationship do
    # user.rbのaliasesから参照
    # association :follower
    # association :followed
    follower_id    { FactoryBot.create(:user).id }
    followed_id    { FactoryBot.create(:user).id }
  end
end