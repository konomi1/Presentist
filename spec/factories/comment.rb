FactoryBot.define do
  factory :comment do
    comment   { Faker::Lorem.characters(number: 50) }
    # FK
    association :present
    association :user
  end
end