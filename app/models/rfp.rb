# == Schema Information
#
# Table name: rfps
#
#  id                  :bigint           not null, primary key
#  bid_type            :integer
#  start_year          :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  buyer_id            :bigint           not null
#  procurement_type_id :bigint
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
  belongs_to :buyer, inverse_of: :rfps
  belongs_to :procurement_type, inverse_of: :rfps
  has_many :scores, -> { joins(:score_category).order('score_categories.position ASC') }, inverse_of: :rfp, dependent: :destroy
  has_many :positive_scores, -> { where.not(value: 0).joins(:score_category).order('score_categories.position ASC') }, class_name: 'Score'
  has_many :deliveries, inverse_of: :rfp, dependent: :destroy
  has_one_attached :item_list, dependent: :destroy
  has_one_attached :draft, dependent: :destroy
  has_one_attached :reviewed, dependent: :destroy
  has_one_attached :final, dependent: :destroy

  delegate :district_profile, to: :buyer
  delegate :complete?, to: :district_profile, prefix: true, allow_nil: true

  delegate :name, to: :procurement_type, prefix: true, allow_nil: true # TODO: shouldnt be nil
  # todo: track these all down?
  alias bid_type procurement_type_name

  validates :buyer, :procurement_type, presence: true
  validates :start_year, presence: true, on: [:create, :update, :purpose]

  validates :district_profile_complete?, inclusion: {in: [true]}, on: :complete?
  validates :deliveries, deliveries_presence: true, on: [:deliveries, :complete?]
  validates :score_sheet, score_sheet: true, on: [:scores, :complete?]

  def name
    "#{procurement_type_name} (#{school_year})"
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
