class CreateDistrictProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :district_profiles do |t|
      t.string :district_name, null: false
      t.string :city
      t.string :county
      t.integer :enrolled_students_number
      t.integer :daily_meals_number
      t.integer :schools_number
      t.integer :production_sites_number
      t.references :buyer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
