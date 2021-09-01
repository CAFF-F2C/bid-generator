class RemoveFieldsFromDistrictProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :district_profiles, :schools_number, :integer
    remove_column :district_profiles, :production_sites_number, :integer
  end
end
