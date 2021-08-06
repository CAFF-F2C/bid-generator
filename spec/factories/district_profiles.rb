# == Schema Information
#
# Table name: district_profiles
#
#  id                       :bigint           not null, primary key
#  city                     :string
#  county                   :string
#  daily_meals_number       :integer
#  district_name            :string           not null
#  enrolled_students_number :integer
#  production_sites_number  :integer
#  schools_number           :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  buyer_id                 :bigint           not null
#
# Indexes
#
#  index_district_profiles_on_buyer_id  (buyer_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => buyers.id)
#
FactoryBot.define do
  factory :district_profile do
    district_name { 'MyString' }
    buyer
  end
end
