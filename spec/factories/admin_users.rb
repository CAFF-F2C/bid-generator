FactoryBot.define do
  factory :admin_user do
    full_name { [Faker::Name.first_name, Faker::Name.last_name].join(' ') }
    sequence(:email) { |n| "test-admin-#{n}@example.com" }
    password { Faker::Internet.password }
  end
end
