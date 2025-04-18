# == Schema Information
#
# Table name: score_categories
#
#  id                       :bigint           not null, primary key
#  deleted_at               :datetime
#  description              :text             not null
#  name                     :string           not null
#  point_awarded_basis      :text
#  point_split_descriptions :text
#  position                 :integer
#  vendor_questions         :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class ScoreCategory < ApplicationRecord
  acts_as_paranoid
  has_many :procurement_type_score_categories, dependent: :destroy
  has_many :procurement_types, through: :procurement_type_score_categories, inverse_of: :score_categories

  validates :name, :description, presence: true
end
