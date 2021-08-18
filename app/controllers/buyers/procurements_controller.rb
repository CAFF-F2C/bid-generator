class Buyers::ProcurementsController < ApplicationController
  layout 'buyers'
  def edit
    @district_profile = current_buyer.district_profile
    redirect_to new_buyers_district_profile_path unless @district_profile.present?
  end

  def update
    @district_profile = current_buyer.district_profile
    redirect_to new_buyers_district_profile_path unless @district_profile.present?

    if @district_profile.update(district_profile_params)
      flash[:success] = 'District Profile was successfully updated.'
      redirect_to buyers_district_profile_path if params[:commit] == 'Save and exit'
      redirect_to buyers_district_profile_locations_path if params[:commit] == 'Next'
    else
      flash[:alert] = 'District Profile could not be saved.'
      render :edit
    end
  end

  private

  def district_profile_params
    params.require(:district_profile).permit(:local_percentage, :price_verified, :allow_piggyback, :required_insurance_aggregate, :required_insurance_automobile, :required_insurance_per_incident)
  end
end
