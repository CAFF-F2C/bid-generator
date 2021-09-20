class Buyers::ReviewedsController < ApplicationController
  after_action :verify_authorized
  layout 'buyers'

  def update
    @rfp ||= Rfp.find(params[:rfp_id])
    authorize(@rfp)
    @rfp.reviewed.attach(item_list_params[:reviewed])
    redirect_to buyers_rfp_path(@rfp)
  end

  private

  def item_list_params
    params.require(:rfp).permit(:reviewed)
  end
end
