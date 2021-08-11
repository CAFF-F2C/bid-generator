FactoryBot.define do
  factory :buyer do
    full_name { [Faker::Name.first_name, Faker::Name.last_name].join(' ') }
    sequence(:email) { |n| "test-buyer-#{n}@example.com" }
    password { Faker::Internet.password }

    trait :confirmed do
      confirmed_at { 1.second.ago }
    end
  end
end
