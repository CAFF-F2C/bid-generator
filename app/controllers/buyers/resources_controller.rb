class Buyers::ResourcesController < Buyers::ApplicationController
  skip_before_action :authenticate_buyer!

  def show
    redirect_to Rails.application.config.external_resources_link, allow_other_host: true
  end
end
