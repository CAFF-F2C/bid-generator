class CreateScorePresetValues < ActiveRecord::Migration[7.0]
  def change
    create_table :score_preset_values do |t|
      t.belongs_to :score_preset, null: false, foreign_key: true
      t.belongs_to :score_category, null: false, foreign_key: true
      t.integer :value, null: false

      t.timestamps
    end
    add_index :score_preset_values, [:score_preset_id, :score_category_id], unique: true, name: 'preset_values_on_preset_id_and_category_id'
  end
end
