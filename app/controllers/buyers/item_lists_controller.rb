class Buyers::ItemListsController < ApplicationController
  after_action :verify_authorized
  layout 'buyers'

  def edit
    authorize(current_rfp)
  end

  def update
    authorize(current_rfp)
    current_rfp.item_list.attach(item_list_params[:item_list])
    redirect_to edit_buyers_rfp_item_list_path(current_rfp)
  end

  private

  def current_rfp
    @current_rfp ||= Rfp.find(params[:rfp_id])
  end

  def item_list_params
    params.require(:rfp).permit(:item_list)
  end
end
