class Buyers::DeliveriesController < ApplicationController
  after_action :verify_authorized
  layout 'buyers'

  def index
    authorize(current_rfp, :edit?)
    @deliveries = current_rfp.deliveries
  end

  def new
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.build
  end

  def edit
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.find(params[:id])
  end

  def create
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.build(delivery_params)
    if @delivery.save
      flash[:success] = 'Schedule was successfully created.'
      redirect_to buyers_rfp_deliveries_path(current_rfp)
    else
      flash[:alert] = 'Schedule could not be saved.'
      render :new
    end
  end

  def update
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:success] = 'Schedule was successfully saved.'
      redirect_to buyers_rfp_deliveries_path(current_rfp)
    else
      flash[:alert] = 'Schedule could not be saved.'
      render :edit
    end
  end

  def destroy
    authorize(current_rfp, :edit?)
    schedule = current_rfp.deliveries.find(params[:id])
    schedule.destroy
    redirect_to buyers_rfp_deliveries_path(current_rfp)
  end

  private

  def delivery_params
    params.require(:delivery).permit(:location_id, :deliveries_per_week, :window_start_time, :window_end_time, delivery_days: [])
  end

  def current_rfp
    @current_rfp ||= Rfp.find(params[:rfp_id])
  end
end
