FactoryBot.define do
  factory :delivery do
    rfp
    location
    delivery_days { [] }
    deliveries_per_week { 1 }
    window_start_time { 10 }
    window_end_time { 11 }
  end
end
