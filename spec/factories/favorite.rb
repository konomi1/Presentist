FactoryBot.define do
  factory :favorite do
    association :present
    association :user
  end
end
