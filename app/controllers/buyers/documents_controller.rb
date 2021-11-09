class Buyers::DocumentsController < ApplicationController
  layout 'buyers'

  def index
    @documents = current_buyer.rfps.order(updated_at: :desc).page(params[:page] || 1).per(params[:per_page] || Kaminari.config.default_per_page)
  end
end
