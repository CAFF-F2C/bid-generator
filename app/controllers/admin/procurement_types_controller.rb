class Admin::ProcurementTypesController < Admin::ApplicationController
  def default_sorting_attribute
    :published
  end
  def default_sorting_direction
    :desc
  end
end
