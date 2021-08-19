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

  delegate :name, :description, to: :score_category
end
