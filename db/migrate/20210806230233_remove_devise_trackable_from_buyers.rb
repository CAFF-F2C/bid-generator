class RemoveDeviseTrackableFromBuyers < ActiveRecord::Migration[6.1]
  def change
    remove_column :buyers, :sign_in_count, :integer, default: 0, null: false
    remove_column :buyers, :current_sign_in_at, :datetime
    remove_column :buyers, :last_sign_in_at, :datetime
    remove_column :buyers, :current_sign_in_ip, :string
    remove_column :buyers, :last_sign_in_ip, :string
  end
end
