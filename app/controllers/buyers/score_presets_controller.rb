class Buyers::ScorePresetsController < Buyers::ApplicationController
  after_action :verify_authorized

  def show
    @rfp = Rfp.find(params[:rfp_id])
    @preset = ScorePreset.find(params[:id])
    authorize(@rfp, :edit?)
  end

  def update
    @rfp = Rfp.find(params[:rfp_id])
    preset = ScorePreset.find(params[:id])
    authorize(@rfp, :edit?)

    preset.score_preset_values.each do |value|
      @rfp.scores.where(score_category: value.score_category).first_or_initialize.tap do |score|
        score.value = value.value
        score.save
      end
    end

    redirect_to buyers_rfp_scores_path(@rfp)
  end
end
