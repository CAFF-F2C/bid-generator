class Buyers::DocumentsController < ApplicationController
  layout 'buyers'

  def index
    @documents = current_buyer.rfps.order(updated_at: :desc)
  end
end
