class Buyers::ScoresController < ApplicationController
  layout 'buyers'

  after_action :verify_authorized

  def index
    @rfp = Rfp.find(params[:rfp_id])
    authorize(@rfp, :edit?)
  end

  def create
    @rfp = Rfp.find(params[:rfp_id])
    authorize(@rfp)
    score = @rfp.scores.create(score_params)
    render turbo_stream: turbo_stream.replace('rfp_scores', view_context.render(Buyers::RfpScoresComponent.new(current_rfp: @rfp, current_score: score)))
  end

  def update
    @rfp = Rfp.find(params[:rfp_id])
    authorize(@rfp)
    score = @rfp.scores.find(params[:id])
    score.update(score_params)
    render turbo_stream: turbo_stream.replace('rfp_scores', view_context.render(Buyers::RfpScoresComponent.new(current_rfp: @rfp, current_score: score)))
  end

  private

  def score_params
    params.require(:score).permit(:value, :score_category_id)
  end
end
