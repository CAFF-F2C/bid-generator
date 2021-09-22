class AdminNotificationMailer < ApplicationMailer
  def new_registration(buyer)
    @buyer = buyer
    mail_to = AdminUser.where(notify_signup: true).pluck(:email)
    mail(to: mail_to, subject: 'New Buyer Registration')
  end
end
