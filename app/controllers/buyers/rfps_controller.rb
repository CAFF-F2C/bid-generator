class Buyers::RfpsController < ApplicationController
  after_action :verify_authorized, except: [:new, :create]

  layout 'buyers'

  def new
    @rfp = current_buyer.rfps.build
  end

  def create
    @rfp = current_buyer.rfps.build(rfp_params)

    if @rfp.save
      flash[:success] = 'RFP was successfully created.'
      redirect_to buyers_documents_path if params[:commit] == 'Save and exit'
      redirect_to buyers_rfp_scores_path(@rfp) if params[:commit] == 'Next'
    else
      flash[:alert] = @rfp.errors.full_messages
      render :new
    end
  end

  def show
    @rfp = Rfp.find(params[:id])
    authorize @rfp
  end

  def edit
    @rfp = Rfp.find(params[:id])
    authorize @rfp
  end

  def update
    @rfp = Rfp.find(params[:id])
    authorize @rfp
    @rfp.assign_attributes(rfp_params)

    if @rfp.save
      flash[:success] = 'RFP was successfully updated.'
      redirect_to buyers_documents_path if params[:commit] == 'Save and exit'
      redirect_to buyers_rfp_scores_path(@rfp) if params[:commit] == 'Next'
    else
      flash[:alert] = @rfp.errors.full_messages
      render :edit
    end
  end

  def destroy
    @rfp = Rfp.find(params[:id])
    authorize @rfp
    if @rfp.destroy
      flash[:notice] = 'RFP was deleted.'
    else
      flash[:alert] = 'RFP could not be deleted.'
    end
    redirect_to buyers_documents_path
  end

  private

  def rfp_params
    params.require(:rfp).permit(:bid_type, :start_year)
  end
end
