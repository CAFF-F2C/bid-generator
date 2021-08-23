class Buyers::ScoresController < ApplicationController
  after_action :verify_authorized
  layout 'buyers'

  def index
    authorize(current_rfp, :edit?)
  end

  def create
    authorize(current_rfp)
    score = current_rfp.scores.create(score_params)
    render turbo_stream: turbo_stream.replace('rfp_scores', view_context.render(Buyers::RfpScoresComponent.new(current_rfp: current_rfp, current_score: score)))
  end

  def update
    authorize(current_rfp)
    score = current_rfp.scores.find(params[:id])
    score.update(score_params)
    render turbo_stream: turbo_stream.replace('rfp_scores', view_context.render(Buyers::RfpScoresComponent.new(current_rfp: current_rfp, current_score: score)))
  end

  private

  def current_rfp
    @current_rfp ||= Rfp.find(params[:rfp_id])
  end

  def score_params
    params.require(:score).permit(:value, :score_category_id)
  end
end
