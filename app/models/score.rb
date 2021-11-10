# == Schema Information
#
# Table name: scores
#
#  id                :bigint           not null, primary key
#  value             :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  rfp_id            :bigint           not null
#  score_category_id :bigint           not null
#
class Score < ApplicationRecord
  belongs_to :rfp
  belongs_to :score_category
  validates :rfp, :score_category, :value, presence: true
  validates :value, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validates :score_category_id, uniqueness: {scope: :rfp_id}

  delegate :name, :description, :point_awarded_basis, :point_split_descriptions, to: :score_category
end
