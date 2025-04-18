class CreateProcurementTypeScoreCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :procurement_type_score_categories do |t|
      t.belongs_to :procurement_type, null: false, foreign_key: true
      t.belongs_to :score_category, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end

    change_column_null :score_categories, :position, true
  end
end
