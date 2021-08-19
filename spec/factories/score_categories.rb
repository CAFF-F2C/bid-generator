FactoryBot.define do
  factory :score_category do
    name { 'category name' }
    description { 'This is the description of the scoring category' }
    sequence(:position)
  end
end
