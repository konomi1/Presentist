FactoryBot.define do
  factory :relationship do
    # user.rbのaliasesから参照
    association :follower
    association :followed
  end
end