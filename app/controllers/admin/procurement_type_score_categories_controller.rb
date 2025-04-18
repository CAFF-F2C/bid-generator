class Admin::ProcurementTypeScoreCategoriesController < Admin::ApplicationController
  def after_resource_updated_path(requested_resource)
    admin_procurement_type_path(requested_resource.procurement_type)
  end
end
