class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.belongs_to :rfp, null: false, foreign_key: true
      t.belongs_to :score_category, null: false, foreign_key: true
      t.integer :value, null: false, default: 0

      t.timestamps
    end
  end
end
