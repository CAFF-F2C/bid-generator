# == Schema Information
#
# Table name: procurement_type_score_categories
#
#  id                  :bigint           not null, primary key
#  position            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  procurement_type_id :bigint           not null
#  score_category_id   :bigint           not null
#
class ProcurementTypeScoreCategory < ApplicationRecord
  belongs_to :procurement_type
  belongs_to :score_category
  validates :procurement_type, :score_category, presence: true

  delegate :name, to: :score_category
end
