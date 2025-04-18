class ScoreSheet
  include ActiveModel::Validations

  attr_accessor :rfp, :scores

  delegate :positive_scores, :total_score, to: :rfp
  validates :positive_scores, presence: true
  validate :valid_scores

  def initialize(rfp:)
    @rfp = rfp
    @scores = find_or_initialize_scores
  end

  def find_or_initialize_scores
    rfp_scores = @rfp.score_categories.map do |score_category|
      @rfp.scores.find_or_initialize_by(score_category_id: score_category.id)
    end
    rfp_scores.first.assign_attributes(value: 100) unless rfp_scores.blank? || rfp_scores.first.persisted?
    rfp_scores
  end

  private

  def valid_scores
    @scores.each do |score|
      if score.value > @scores.first.value
        score.errors.add(:base, :invalid_highest, message: "#{@scores.first.name} must be the highest score")
        @scores.first.errors.add(:base, :invalid_highest, message: "#{@scores.first.name} must be the highest score")
        errors.add(:base, :invalid_highest, message: "#{@scores.first.name} must be the highest score")
      elsif score.value != 0 && total_score != 100
        score.errors.add(:base, :total_score, message: 'Total must equal 100')
        errors.add(:base, :total_score, message: 'Total must equal 100')
      end
    end
  end
end
