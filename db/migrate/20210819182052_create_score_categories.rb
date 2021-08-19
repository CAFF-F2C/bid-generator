class CreateScoreCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :score_categories do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :position, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :score_categories, :position
    add_index :score_categories, :deleted_at
  end
end
