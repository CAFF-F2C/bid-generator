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
class DistrictProfile < ApplicationRecord
  validates :district_name, presence: true

  belongs_to :buyer
end
