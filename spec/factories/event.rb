FactoryBot.define do
  factory :event do
    date          { Faker::Date.forward(days: 7) }
    scene_status  { Faker::Number.within(range: 0..10) }
    memo          { Faker::Lorem.characters(number: 50) }
    ready_status  { 0 }
    # FK
    association :friend
    user { friend.user }
  end
end
