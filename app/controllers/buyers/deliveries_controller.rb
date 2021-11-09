class Buyers::DeliveriesController < ApplicationController
  layout 'buyers'

  after_action :verify_authorized

  def index
    authorize(current_rfp, :edit?)
    @rfp = current_rfp
  end

  def new
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.build(window_start_time: 4, window_end_time: 5)
  end

  def edit
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.find(params[:id])
  end

  def create
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.build(delivery_params)
    respond_to do |format|
      if @delivery.save
        format.any do
          flash[:success] = 'Schedule was successfully created.'
          redirect_to buyers_rfp_deliveries_path(current_rfp), status: :see_other
        end
      else
        flash.now[:alert] = 'Schedule could not be saved.'
        format.html { render :new }
        format.turbo_stream { render :create }
      end
    end
  end

  def update
    authorize(current_rfp, :edit?)
    @delivery = current_rfp.deliveries.find(params[:id])
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.any do
          flash[:success] = 'Schedule was successfully updated.'
          redirect_to buyers_rfp_deliveries_path(current_rfp), status: :see_other
        end
      else
        flash.now[:alert] = 'Schedule could not be saved.'
        format.html { render :edit }
        format.turbo_stream { render :update }
      end
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
    unprocessed_params.merge(delivery_days: unprocessed_params.fetch(:delivery_days, []).reject(&:blank?))
  end

  def unprocessed_params
    params.require(:delivery).permit(:location_id, :deliveries_per_week, :window_start_time, :window_end_time, delivery_days: [])
  end

  def current_rfp
    @current_rfp ||= Rfp.find(params[:rfp_id])
  end
end
