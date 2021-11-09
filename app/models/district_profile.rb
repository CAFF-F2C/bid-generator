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
  belongs_to :buyer, inverse_of: :district_profile
  delegate :locations, to: :buyer

  validates :district_name,
            :city,
            :county,
            :enrolled_students_number,
            presence: true, on: [:save, :district_information]
  validates :enrolled_students_number, numericality: {only_integer: true, allow_nil: true, greater_than: 0}, on: [:save, :district_information]

  validates :contact_phone_number, phone: {allow_blank: true}, on: [:rfp_contact]
  validates :contact_full_name,
            :contact_department_name,
            :contact_mailing_address_city,
            :contact_mailing_address_state,
            :contact_mailing_address_street,
            :contact_mailing_address_zip,
            :contact_phone_number,
            :contact_title,
            presence: true, on: [:rfp_contact]

  validates :allow_piggyback, :price_verified, inclusion: {in: [true, false], allow_blank: false}, on: [:procurement_terms]
  validates :local_percentage,
            :required_insurance_aggregate,
            :required_insurance_automobile,
            :required_insurance_per_incident,
            presence: true, on: [:procurement_terms]

  validates :locations, presence: true, on: [:locations]

  def complete?
    valid?([:district_information, :rfp_contact, :procurement_terms, :locations])
  end

  def address
    return unless contact_mailing_address_city? && contact_mailing_address_state? && contact_mailing_address_street? && contact_mailing_address_zip

    "#{contact_mailing_address_street} #{contact_mailing_address_city}, #{contact_mailing_address_state} #{contact_mailing_address_zip}"
  end
end
