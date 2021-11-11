class Buyers::DistrictProfiles::LocationsController < Buyers::ApplicationController
  before_action -> { redirect_to edit_buyers_district_profile_path }, unless: -> { current_buyer.district_profile.present? }
  after_action :verify_authorized, except: [:index, :new, :create]

  def index
    @district_profile = current_buyer.district_profile
  end

  def new
    @location = current_buyer.locations.build
  end

  def create
    @location = current_buyer.locations.build(location_params)
    respond_to do |format|
      if @location.save
        format.any do
          flash[:success] = 'Location was successfully created.'
          redirect_to buyers_district_profile_locations_path, status: :see_other
        end
      else
        flash.now[:alert] = 'Location could not be saved.'
        format.html { render :new }
        format.turbo_stream { render :create }
      end
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
    respond_to do |format|
      if @location.save
        format.any do
          flash[:success] = 'Location was successfully updated.'
          redirect_to buyers_district_profile_locations_path, status: :see_other
        end
      else
        flash.now[:alert] = 'Location could not be saved.'
        format.html { render :edit }
        format.turbo_stream { render :update }
      end
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
