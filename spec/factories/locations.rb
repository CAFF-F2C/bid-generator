FactoryBot.define do
  factory :location do
    buyer
    name { 'Delivery location' }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip }
  end
end
