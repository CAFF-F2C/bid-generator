class Buyers::DistrictProfileNavComponentPreview < ViewComponent::Preview
  def default
    render(Buyers::DistrictProfileNavComponent.new(current_path: Rails.application.routes.url_helpers.new_buyers_district_profile_path))
  end

  def contact
    render(Buyers::DistrictProfileNavComponent.new(current_path: Rails.application.routes.url_helpers.edit_buyers_district_profile_contact_path))
  end

  def procurement
    render(Buyers::DistrictProfileNavComponent.new(current_path: Rails.application.routes.url_helpers.edit_buyers_district_profile_procurement_path))
  end

  def locations
    render(Buyers::DistrictProfileNavComponent.new(current_path: Rails.application.routes.url_helpers.buyers_district_profile_locations_path))
  end
end
