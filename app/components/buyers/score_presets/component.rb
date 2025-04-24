class Buyers::ScorePresets::Component < ViewComponent::Base
  def initialize(current_rfp:, preset:)
    @current_rfp = current_rfp
    @preset = preset
    @score_sheet = @current_rfp.score_sheet
  end

  def scores
    @score_sheet.scores
  end

  def category_value(score)
    @preset.category_value(score.score_category)
  end

  def category_difference(score)
    category_value(score) - score.value
  end
end
