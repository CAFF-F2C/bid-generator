# == Schema Information
#
# Table name: district_profiles
#
#  id                              :bigint           not null, primary key
#  allow_piggyback                 :boolean
#  city                            :string
#  contact_department_name         :string
#  contact_full_name               :string
#  contact_mailing_address_city    :string
#  contact_mailing_address_state   :string
#  contact_mailing_address_street  :string
#  contact_mailing_address_zip     :string
#  contact_phone_number            :string
#  contact_title                   :string
#  county                          :string
#  daily_meals_number              :integer
#  district_name                   :string           not null
#  enrolled_students_number        :integer
#  local_percentage                :integer
#  price_verified                  :boolean
#  required_insurance_aggregate    :integer
#  required_insurance_automobile   :integer
#  required_insurance_per_incident :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  buyer_id                        :bigint           not null
#
class DistrictProfile < ApplicationRecord
  validates :district_name, presence: true

  belongs_to :buyer, inverse_of: :district_profile
end
