class Buyers::RfpScoresComponent < ViewComponent::Base
  def initialize(current_rfp:, current_score: nil)
    @current_rfp = current_rfp
    @current_score = current_score
    @score_sheet = @current_rfp.score_sheet
    @score_sheet.valid?
  end

  def scores
    @score_sheet.scores
  end

  def current_score?(score_id)
    return false if @current_score.blank?

    score_id == @current_score.id
  end

  def errors
    @errors ||= @score_sheet.errors
  end

  def total_score
    @current_rfp.total_score
  end
end
