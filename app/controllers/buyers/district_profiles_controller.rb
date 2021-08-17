# Edits a Buyer's District Profile
class Buyers::DistrictProfilesController < ApplicationController
  layout 'buyers'

  def show
    redirect_to new_buyers_district_profile_path unless district_profile.persisted?
  end

  def new
    redirect_to edit_buyers_district_profile_path if district_profile.persisted?
  end

  def edit
    redirect_to new_buyers_district_profile_path unless district_profile.persisted?
  end

  def create
    @district_profile = current_buyer.build_district_profile(district_profile_params)
    if @district_profile.save
      flash[:success] = 'District Profile was successfully created.'
      redirect_to buyers_district_profile_path if params[:commit] == 'Save and exit'
      redirect_to edit_buyers_district_profile_contact_path if params[:commit] == 'Next'
    else
      flash[:alert] = 'District Profile could not be saved.'
      render :new
    end
  end

  def update
    if district_profile.update(district_profile_params)
      flash[:success] = 'District Profile was successfully updated.'
      redirect_to buyers_district_profile_path if params[:commit] == 'Save and exit'
      redirect_to edit_buyers_district_profile_contact_path if params[:commit] == 'Next'
    else
      flash[:alert] = 'District Profile could not be saved.'
      render :edit
    end
  end

  private

  def district_profile
    @district_profile = current_buyer.district_profile || current_buyer.build_district_profile
  end

  def district_profile_params
    params.require(:district_profile).permit(
      :district_name, :city, :county, :enrolled_students_number,
      :daily_meals_number, :schools_number, :production_sites_number
    )
  end
end
