class Buyers::DistrictProfiles::ContactsController < ApplicationController
  layout 'buyers'

  before_action -> { redirect_to edit_buyers_district_profile_path }, unless: -> { current_buyer.district_profile.present? }

  def edit
    @district_profile = current_buyer.district_profile
  end

  def update
    @district_profile = current_buyer.district_profile
    respond_to do |format|
      if @district_profile.update(district_profile_params)
        if params.key?(:draft)
          @district_profile.valid?(:rfp_contact)
          flash.now[:success] = 'District Profile was successfully updated.'
          format.html { render :edit }
          format.turbo_stream { render :update }
        else
          format.any do
            flash[:success] = 'District Profile was successfully updated.'
            redirect_to edit_buyers_district_profile_procurement_path, status: :see_other
          end
        end
      else
        flash.now[:alert] = 'District Profile could not be saved.'
        format.html { render :edit }
        format.turbo_stream { render :update }
      end
    end
  end

  private

  def district_profile_params
    params.require(:district_profile).permit(:contact_full_name, :contact_mailing_address_city, :contact_department_name, :contact_full_name, :contact_mailing_address_state, :contact_mailing_address_street, :contact_mailing_address_zip, :contact_phone_number, :contact_title)
  end
end
