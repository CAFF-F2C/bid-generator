FactoryBot.define do
  factory :district_profile do
    district_name { 'MyDistrict' }
    buyer

    trait :complete do
      city { 'ACity' }
      county { 'Suchacounty' }
      contact_full_name { Faker::Name.name }
      contact_department_name { 'District Food Program' }
      contact_mailing_address_city { 'ACity' }
      contact_mailing_address_state { 'California' }
      contact_mailing_address_street { '123 Main St' }
      contact_mailing_address_zip { '12345' }
      contact_phone_number { '5553334444' }
      contact_title { 'Director' }
      enrolled_students_number { 1000 }
      allow_piggyback { true }
      local_percentage { 25 }
      price_verified { true }
      required_insurance_aggregate { 1_000_000 }
      required_insurance_automobile { 100_000 }
      required_insurance_per_incident { 50_000 }
    end
  end
end
