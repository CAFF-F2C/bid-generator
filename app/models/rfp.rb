# == Schema Information
#
# Table name: rfps
#
#  id         :bigint           not null, primary key
#  bid_type   :integer          not null
#  start_year :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  buyer_id   :bigint           not null
#

class DeliveriesPresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, :deliveries_blank if value.blank?
  end
end

class ScoreSheetValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, :scores_invalid unless value.valid?
  end
end

class Rfp < ApplicationRecord
  BID_TYPES = ['Produce', 'Dairy', 'Bread', 'Broadline', 'Grocery', 'Supplies', 'Equipment'].freeze
  enum bid_type: BID_TYPES

  belongs_to :buyer, inverse_of: :rfps
  has_many :scores, -> { joins(:score_category).order('score_categories.position ASC') }, inverse_of: :rfp, dependent: :destroy
  has_many :positive_scores, -> { where.not(value: 0).joins(:score_category).order('score_categories.position ASC') }, class_name: 'Score'
  has_many :deliveries, inverse_of: :rfp, dependent: :destroy
  has_one_attached :item_list, dependent: :destroy
  has_one_attached :draft, dependent: :destroy
  has_one_attached :reviewed, dependent: :destroy
  has_one_attached :final, dependent: :destroy

  delegate :district_profile, to: :buyer
  delegate :complete?, to: :district_profile, prefix: true, allow_nil: true

  validates :buyer, presence: true
  validates :bid_type, inclusion: BID_TYPES, on: [:create, :update, :purpose]
  validates :bid_type, :start_year, presence: true, on: [:create, :update, :purpose]

  validates :district_profile_complete?, inclusion: {in: [true]}, on: :complete?
  validates :deliveries, deliveries_presence: true, on: [:deliveries, :complete?]
  validates :score_sheet, score_sheet: true, on: [:scores, :complete?]

  def name
    "#{bid_type} (#{school_year})"
  end

  def school_year
    "#{start_year} - #{start_year + 1}"
  end

  def complete?
    valid?(:complete?)
  end

  def score_sheet
    @score_sheet ||= ScoreSheet.new(rfp: self)
  end

  def status
    @status ||=
      [
        [:final, final.attached?],
        [:review, reviewed.attached?],
        [:draft, draft.attached?],
        [:complete, complete?],
        [:in_progress, true]
      ].find { |s| s[1] }[0]
  end

  def total_score
    scores.sum(&:value)
  end
end
