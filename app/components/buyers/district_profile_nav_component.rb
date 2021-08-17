class Buyers::DistrictProfileNavComponent < ViewComponent::Base
  def initialize(current_path:)
    @current_path = current_path
  end

  def progress_percent
    case @current_path
    when new_buyers_district_profile_path, edit_buyers_district_profile_path
      '12.5%'
    when edit_buyers_district_profile_contact_path
      '37.5%'
    when 'procurement_path'
      '62.5%'
    when 'locations_path'
      '87.5%'
    end
  end

  def classes(path)
    current_page?(path) ? 'current' : ''
  end

  def current_page?(path)
    if @current_path == new_buyers_district_profile_path || @current_path == edit_buyers_district_profile_path
      path == new_buyers_district_profile_path || path == edit_buyers_district_profile_path
    else
      path == @current_path
    end
  end
end
