# == Schema Information
#
# Table name: deliveries
#
#  id                  :bigint           not null, primary key
#  deliveries_per_week :integer
#  delivery_days       :integer          default([]), is an Array
#  window_end_time     :integer
#  window_start_time   :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  location_id         :bigint           not null
#  rfp_id              :bigint           not null
#
class Delivery < ApplicationRecord
  belongs_to :rfp, inverse_of: :deliveries
  belongs_to :location, inverse_of: :deliveries

  delegate :name, to: :location, prefix: true, allow_nil: true

  validates :rfp, presence: true
  validates :location_id, presence: true
  validates :delivery_days, inclusion: {in: [*1..5]}
  validates :window_start_time, inclusion: {in: [*4..15]}
  validates :window_end_time, inclusion: {in: [*4..15]}
  validates :window_end_time, numericality: {only_integer: true, greater_than_or_equal_to: ->(delivery) { delivery.window_start_time }}

  def display_delivery_days
    delivery_days.map { |d| Date::DAYNAMES[d] }.join(', ')
  end

  def display_delivery_window
    [I18n.t(window_start_time, scope: [:buyers, :delivery, :time]), I18n.t(window_end_time, scope: [:buyers, :delivery, :time])].join(' - ')
  end
end
