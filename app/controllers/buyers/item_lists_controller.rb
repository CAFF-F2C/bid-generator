class Buyers::ItemListsController < Buyers::ApplicationController
  after_action :verify_authorized

  def edit
    @rfp = Rfp.find(params[:rfp_id])
    authorize(@rfp)
  end

  def update
    @rfp = Rfp.find(params[:rfp_id])
    authorize(@rfp)
    respond_to do |format|
      if @rfp.item_list.attach(item_list_params[:item_list])
        flash.now[:success] = 'District Profile was successfully updated.'
      else
        flash.now[:alert] = 'District Profile could not be saved.'
      end
      format.html { render :edit }
      format.turbo_stream { render :update }
    end
  end

  private

  def item_list_params
    params.require(:rfp).permit(:item_list)
  end
end
