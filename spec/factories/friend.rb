FactoryBot.define do
  factory :friend do
    name        { Gimei.name.kanji }
    kana_name   { Gimei.name.first.katakana }
    relation    { Faker::Number.within(range: 1..13) }
    gender      { 0 }
    memo        { Faker::Lorem.characters(number: 50) }
    # FK
    association :user
  end
end
