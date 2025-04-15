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
  scope :published, -> { where(published: true) }
  validates :name, presence: true
end
