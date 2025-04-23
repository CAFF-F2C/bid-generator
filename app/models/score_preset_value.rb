# == Schema Information
#
# Table name: score_preset_values
#
#  id                :bigint           not null, primary key
#  value             :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  score_category_id :bigint           not null
#  score_preset_id   :bigint           not null
#
class ScorePresetValue < ApplicationRecord
  belongs_to :score_preset
  belongs_to :score_category

  validates :score_preset, :score_category, :value, presence: true
  validates :value, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validates :score_category_id, uniqueness: {scope: :score_preset_id}
  validates :score_category, inclusion: {in: ->(value) { value.procurement_type.score_categories }, message: 'is not included in procurement type.'}, if: -> { procurement_type.present? }

  delegate :procurement_type, to: :score_preset, allow_nil: true
end
