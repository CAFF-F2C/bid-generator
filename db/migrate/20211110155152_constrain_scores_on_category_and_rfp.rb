class ConstrainScoresOnCategoryAndRfp < ActiveRecord::Migration[6.1]
  def change
    remove_index :scores, :score_category_id
    add_index :scores, [:score_category_id, :rfp_id], unique: true
  end
end
