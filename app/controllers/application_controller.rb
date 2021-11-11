class ApplicationController < ActionController::Base
  include Pundit

  def after_sign_in_path_for(resource)
    return admin_root_path if resource.instance_of?(AdminUser)

    buyers_documents_path if resource.instance_of?(Buyer)
  end
end
