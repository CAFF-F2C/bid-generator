# Shows list of all RFPs
class Buyers::DocumentsController < ApplicationController
  layout 'buyers'

  def index
    @documents = current_buyer.rfps
  end
end
