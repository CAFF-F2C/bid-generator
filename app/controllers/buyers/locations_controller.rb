class Buyers::LocationsController < ApplicationController
  after_action :verify_authorized, except: [:index, :new, :create]
  layout 'buyers'

  def index
    @locations = current_buyer.locations
  end

  def new
    @location = current_buyer.locations.build
  end

  def create
    @location = current_buyer.locations.build(location_params)
    if @location.save
      flash[:success] = 'Location was successfully created.'
      redirect_to buyers_district_profile_locations_path
    else
      flash[:alert] = 'Location could not be saved.'
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
    authorize(@location)
  end

  def update
    @location = Location.find(params[:id])
    authorize(@location)
    @location.assign_attributes(location_params)
    if @location.save
      flash[:success] = 'Location was successfully updated.'
      redirect_to buyers_district_profile_locations_path
    else
      flash[:alert] = 'Location could not be saved.'
      render :edit
    end
  end

  def destroy
    location = Location.find(params[:id])
    authorize(location)
    location.destroy
    redirect_to buyers_district_profile_locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :street_address, :city, :state, :zip_code)
  end
end
