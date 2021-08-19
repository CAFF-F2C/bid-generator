# == Schema Information
#
# Table name: score_categories
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text             not null
#  name        :string           not null
#  position    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ScoreCategory < ApplicationRecord
  acts_as_paranoid
  validates :name, :description, :position, presence: true
end
