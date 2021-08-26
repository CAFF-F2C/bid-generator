FactoryBot.define do
  factory :delivery do
    rfp
    location
    delivery_days { [] }
    deliveries_per_week { 1 }
  end
end
