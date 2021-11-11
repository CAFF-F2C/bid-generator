class Buyers::FinalsController < Buyers::ApplicationController
  after_action :verify_authorized

  def update
    @rfp ||= Rfp.find(params[:rfp_id])
    authorize(@rfp)
    @rfp.final.attach(item_list_params[:final])
    redirect_to buyers_rfp_path(@rfp)
  end

  private

  def item_list_params
    params.require(:rfp).permit(:final)
  end
end
