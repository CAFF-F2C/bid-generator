class AddNotifySignupToAdminUser < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_users, :notify_signup, :boolean, default: false
  end
end
