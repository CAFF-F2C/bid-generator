class Buyers::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do |buyer|
      AdminNotificationMailer.new_registration(resource).deliver if buyer.confirmed?
    end
  end
end
