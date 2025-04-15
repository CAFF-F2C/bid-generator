class AddProcurementTypeToRfp < ActiveRecord::Migration[7.0]
  def change
    add_reference :rfps, :procurement_type, foreign_key: true
    change_column_null :rfps, :bid_type, true
  end
end
