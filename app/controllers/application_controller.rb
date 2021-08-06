class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_buyer!, unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user() = current_buyer

  def after_sign_in_path_for(resource)
    return admin_root_path if resource.instance_of?(AdminUser)

    buyers_documents_path if resource.instance_of?(Buyer)
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
