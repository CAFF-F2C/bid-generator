# == Schema Information
#
# Table name: deliveries
#
#  id                  :bigint           not null, primary key
#  deliveries_per_week :integer
#  delivery_days       :integer          default([]), is an Array
#  delivery_time       :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  location_id         :bigint           not null
#  rfp_id              :bigint           not null
#
class Delivery < ApplicationRecord
  DELIVERY_TIMES = ['Early Morning (6am - 8am)', 'Morning (8am - 10am)', 'Late Morning (10am - 12pm)', 'Lunch (12pm - 2pm)', 'Afternoon (2pm - 4pm)', 'Evening (4pm - 6pm)'].freeze

  belongs_to :rfp, inverse_of: :deliveries
  belongs_to :location, inverse_of: :deliveries

  enum delivery_time: DELIVERY_TIMES

  delegate :name, to: :location, prefix: true, allow_nil: true

  validates :rfp, presence: true
  validates :location, presence: true
  validates :delivery_days, inclusion: {in: [*1..5]}

  def display_delivery_days
    delivery_days.map { |d| Date::DAYNAMES[d] }.join(', ')
  end
end
