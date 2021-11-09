class Buyers::ResourcesController < ApplicationController
  skip_before_action :authenticate_buyer!

  def show
    redirect_to Rails.application.config.external_resources_link
  end
end
