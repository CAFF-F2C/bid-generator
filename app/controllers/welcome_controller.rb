class WelcomeController < ApplicationController
  skip_before_action :authenticate_buyer!, only: [:index]
  def index
  end
end
