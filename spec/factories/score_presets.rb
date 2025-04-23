FactoryBot.define do
  factory :score_preset do
    procurement_type
    name { 'TestPreset' }
    description { 'Preset description' }
    published { true }
  end
end
