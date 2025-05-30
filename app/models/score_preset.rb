# == Schema Information
#
# Table name: score_presets
#
#  id                  :bigint           not null, primary key
#  description         :string           not null
#  name                :string           not null
#  published           :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  procurement_type_id :bigint           not null
#
class ScorePreset < ApplicationRecord
  belongs_to :procurement_type
  has_many :score_preset_values, inverse_of: :score_preset
  validates :name, presence: true
  scope :published, -> { where(published: true) }

  def category_value(category)
    score_preset_values.find_by(score_category: category)&.value || 0
  end
end
