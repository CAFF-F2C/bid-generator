# Preview all emails at http://localhost:3000/rails/mailers/admin_notification
class AdminNotificationPreview < ActionMailer::Preview
  def new_registration
    buyer = OpenStruct.new(email: 'preview@example.com')
    AdminNotificationMailer.new_registration(buyer)
  end
end
