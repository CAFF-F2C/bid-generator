class Buyers::DistrictProfilesController < Buyers::ApplicationController
  before_action -> { redirect_to edit_buyers_district_profile_path }, if: -> { current_buyer.district_profile.blank? }, only: [:show]

  def show
    @district_profile = current_buyer.district_profile || current_buyer.build_district_profile
  end

  def edit
    @district_profile = current_buyer.district_profile || current_buyer.build_district_profile
  end

  def update
    @district_profile = current_buyer.district_profile || current_buyer.build_district_profile
    respond_to do |format|
      if @district_profile.update(district_profile_params)
        if params.key?(:draft)
          @district_profile.valid?(:district_information)
          format.html { render :edit }
          format.turbo_stream { render :update }
        else
          format.any do
            flash[:success] = 'District Profile was successfully updated.'
            redirect_to edit_buyers_district_profile_contact_path, status: :see_other
          end
        end
      else
        flash[:alert] = 'District Profile could not be saved.'
        format.html { render :edit }
        format.turbo_stream { render :update }
      end
    end
  end

  private

  def district_profile_params
    params.require(:district_profile).permit(:district_name, :city, :county, :enrolled_students_number)
  end
end
