class CreateProcurementTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :procurement_types do |t|
      t.string :name, null: false
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
