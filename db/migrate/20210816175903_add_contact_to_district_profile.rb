class AddContactToDistrictProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :district_profiles, :contact_full_name, :string
    add_column :district_profiles, :contact_department_name, :string
    add_column :district_profiles, :contact_title, :string
    add_column :district_profiles, :contact_phone_number, :string
    add_column :district_profiles, :contact_mailing_address_street, :string
    add_column :district_profiles, :contact_mailing_address_city, :string
    add_column :district_profiles, :contact_mailing_address_state, :string
    add_column :district_profiles, :contact_mailing_address_zip, :string
  end
end
