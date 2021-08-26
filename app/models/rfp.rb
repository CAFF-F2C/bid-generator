# == Schema Information
#
# Table name: rfps
#
#  id         :bigint           not null, primary key
#  bid_type   :integer          not null
#  start_year :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  buyer_id   :bigint           not null
#
class Rfp < ApplicationRecord
  BID_TYPES = ['Produce', 'Dairy', 'Bread', 'Broadline', 'Grocery', 'Supplies', 'Equipment'].freeze
  enum bid_type: BID_TYPES

  belongs_to :buyer, inverse_of: :rfps
  has_many :scores, inverse_of: :rfp
  has_many :deliveries, inverse_of: :rfp

  validates :bid_type, :start_year, :buyer, presence: true
  validates :bid_type, inclusion: BID_TYPES

  def name
    "#{bid_type} (#{school_year})"
  end

  def school_year
    "#{start_year} - #{start_year + 1}"
  end
end
