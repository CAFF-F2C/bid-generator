class AddProdurementToDistrictProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :district_profiles, :local_percentage, :integer
    add_column :district_profiles, :price_verified, :boolean
    add_column :district_profiles, :allow_piggyback, :boolean
    add_column :district_profiles, :required_insurance_per_incident, :integer
    add_column :district_profiles, :required_insurance_aggregate, :integer
    add_column :district_profiles, :required_insurance_automobile, :integer
  end
end
