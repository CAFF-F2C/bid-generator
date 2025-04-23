class CreateScorePresets < ActiveRecord::Migration[7.0]
  def change
    create_table :score_presets do |t|
      t.belongs_to :procurement_type, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :published

      t.timestamps
    end
  end
end
