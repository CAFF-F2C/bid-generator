class Buyers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:full_name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:full_name, :email, :password, :current_password)
    end
  end

  def after_sign_up_path_for(_resource)
    new_buyer_session_path if is_navigational_format?
  end

  def after_inactive_sign_up_path_for(_resource)
    new_buyer_session_path
  end
end
