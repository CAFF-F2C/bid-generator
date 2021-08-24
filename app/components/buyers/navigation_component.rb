# Display a navigation sidebar for Buyers
class Buyers::NavigationComponent < ViewComponent::Base
  def initialize(current_path:)
    @current_path = current_path
  end

  def external_resources_link
    Rails.application.config.external_resources_link
  end

  def current_page?(path)
    return true if path == @current_path

    district_profile_paths.any?(path) && district_profile_paths.any?(@current_path)
  end

  private

  def district_profile_paths
    [
      new_buyers_district_profile_path,
      edit_buyers_district_profile_path,
      buyers_district_profile_path,
      edit_buyers_district_profile_contact_path,
      edit_buyers_district_profile_procurement_path,
      buyers_district_profile_locations_path
    ].freeze
  end
end
