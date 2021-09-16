class Buyers::DraftsController < ApplicationController
  after_action :verify_authorized

  def create
    authorize(current_rfp)
    ::RfpCompositor.new(current_rfp).attach
    redirect_to buyers_rfp_path(current_rfp)
  end

  private

  def current_rfp
    @current_rfp ||= Rfp.find(params[:rfp_id])
  end
end
