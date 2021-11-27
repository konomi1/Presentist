FactoryBot.define do
  factory :user do      # aliases: [:follower, :followed]
    name      { Gimei.name.kanji }
    email     { Faker::Internet.email }
    birthday  { Faker::Date.birthday(min_age: 18, max_age: 80) }
    gender    { 0 }
    introduce { Faker::Lorem.characters(number: 50) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
