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

  validates :name, :street_address, :city, :state, :zip_code, presence: true

  def full_address
    "#{street_address}, #{city}, #{state} #{zip_code}"
  end
end
