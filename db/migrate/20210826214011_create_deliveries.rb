class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.belongs_to :rfp, null: false, foreign_key: true
      t.belongs_to :location, null: false, foreign_key: true
      t.integer :delivery_days, array: true, default: []
      t.integer :deliveries_per_week
      t.integer :delivery_time

      t.timestamps
    end
  end
end
