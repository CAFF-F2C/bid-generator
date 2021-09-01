class ReplaceDeliveryTimeWithStartEndTime < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :window_start_time, :integer
    add_column :deliveries, :window_end_time, :integer
    remove_column :deliveries, :delivery_time, :integer
  end
end
