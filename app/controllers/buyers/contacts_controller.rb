class Buyers::ContactsController < ApplicationController
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
      redirect_to buyers_district_profile_path
    else
      flash[:alert] = 'District Profile could not be saved.'
      render :edit
    end
  end

  private

  def district_profile_params
    params.require(:district_profile).permit(:contact_full_name, :contact_mailing_address_city, :contact_department_name, :contact_full_name, :contact_mailing_address_state, :contact_mailing_address_street, :contact_mailing_address_zip, :contact_phone_number, :contact_title)
  end
end
