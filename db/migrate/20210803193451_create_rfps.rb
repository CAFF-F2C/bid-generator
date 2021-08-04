class CreateRfps < ActiveRecord::Migration[6.1]
  def change
    create_table :rfps do |t|
      t.belongs_to :buyer, null: false, foreign_key: true
      t.integer :start_year, null: false
      t.integer :bid_type, null: false

      t.timestamps
    end
  end
end
