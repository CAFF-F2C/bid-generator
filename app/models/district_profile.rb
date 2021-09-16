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

class ContactPresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, :contact_blank if value.blank?
  end
end

class ProcurementTermsPresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, :procurement_terms_blank if value.blank?
  end
end

class LocationsPresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, :locations_blank if value.blank?
  end
end

class DistrictProfile < ApplicationRecord
  belongs_to :buyer, inverse_of: :district_profile
  delegate :locations, to: :buyer

  validates :district_name, presence: true
  validates :enrolled_students_number, numericality: {only_integer: true, allow_nil: true}
  validates :daily_meals_number, numericality: {only_integer: true, allow_nil: true}
  validates :city, :county, presence: true, on: :complete?
  validates :allow_piggyback, :price_verified, inclusion: {in: [true, false]}, on: :complete?

  validates :contact_full_name,
            :contact_department_name,
            :contact_mailing_address_city,
            :contact_mailing_address_state,
            :contact_mailing_address_street,
            :contact_mailing_address_zip,
            :contact_phone_number,
            :contact_title,
            contact_presence: true, on: :complete?

  validates :local_percentage,
            :required_insurance_aggregate,
            :required_insurance_automobile,
            :required_insurance_per_incident,
            procurement_terms_presence: true, on: :complete?

  validates :locations, locations_presence: true, on: :complete?

  def complete?
    valid?(:complete?)
  end
end
