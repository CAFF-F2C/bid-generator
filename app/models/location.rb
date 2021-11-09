# == Schema Information
#
# Table name: locations
#
#  id             :bigint           not null, primary key
#  city           :string           not null
#  name           :string           not null
#  state          :string           not null
#  street_address :string           not null
#  zip_code       :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  buyer_id       :bigint           not null
#
class Location < ApplicationRecord
  belongs_to :buyer, inverse_of: :locations

  has_one :district_profile, through: :buyer

  has_many :deliveries, inverse_of: :location, dependent: :restrict_with_error

  validates :name, :street_address, :city, :state, :zip_code, presence: true

  def name_with_address
    "#{name} (#{full_address})"
  end

  def full_address
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end
end
