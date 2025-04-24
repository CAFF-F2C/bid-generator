# == Schema Information
#
# Table name: procurement_types
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  published  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProcurementType < ApplicationRecord
  has_one_attached :template, dependent: :destroy
  has_many :rfps, inverse_of: :procurement_type
  has_many :procurement_type_score_categories, -> { order('procurement_type_score_categories.position ASC') }, dependent: :destroy
  has_many :score_categories, -> { order('procurement_type_score_categories.position ASC') }, through: :procurement_type_score_categories, inverse_of: :procurement_types
  has_many :score_presets

  validates :name, presence: true

  scope :published, -> { where(published: true) }
end
