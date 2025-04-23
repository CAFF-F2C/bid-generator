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
  validates :name, presence: true
  scope :published, -> { where(published: true) }
end
