FactoryBot.define do
  factory :procurement_type_score_category do
    procurement_type
    score_category
    sequence(:position)
  end
end
