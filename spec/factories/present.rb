FactoryBot.define do
  factory :present do
    gift_status     { 0 }
    age             { Faker::Number.within(range: 1..8) }
    item            { Faker::Lorem.characters(number: 20) }
    price           { Faker::Number.number(digits: 4) }
    scene_status    { Faker::Number.within(range: 1..10) }
    return_status   { 1 }
    memo            { Faker::Lorem.characters(number: 50) }

    # FK
    association :friend
    user { friend.user }
  end
end
