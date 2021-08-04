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
      redirect_to buyers_documents_path
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
      redirect_to buyers_documents_path
    else
      flash[:alert] = @rfp.errors.full_messages
      render :edit
    end
  end

  private

  def rfp_params
    params.require(:rfp).permit(:bid_type, :start_year)
  end
end
