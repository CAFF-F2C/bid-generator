class Admin::BuyersController < Admin::ApplicationController
  def scoped_resource
    Buyer.where.not(confirmed_at: nil)
  end
end
