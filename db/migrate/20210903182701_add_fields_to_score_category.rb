class AddFieldsToScoreCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :score_categories, :vendor_questions, :text
    add_column :score_categories, :point_split_descriptions, :text
    add_column :score_categories, :point_awarded_basis, :text
  end
end
