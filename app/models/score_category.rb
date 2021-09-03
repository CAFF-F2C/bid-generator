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
#  position                 :integer          not null
#  vendor_questions         :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class ScoreCategory < ApplicationRecord
  acts_as_paranoid
  validates :name, :description, :position, presence: true
end
