class Admin::RfpsController < Admin::ApplicationController
  def default_sorting_attribute
    :updated_at
  end

  def default_sorting_direction
    :desc
  end
end
