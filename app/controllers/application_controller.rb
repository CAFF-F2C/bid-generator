class ApplicationController < ActionController::Base
  before_action :authenticate_buyer!, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    buyers_documents_path if resource.instance_of?(Buyer)
  end
end
