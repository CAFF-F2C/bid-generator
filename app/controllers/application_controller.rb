class ApplicationController < ActionController::Base
  before_action :authenticate_buyer!, unless: :devise_controller?
end
