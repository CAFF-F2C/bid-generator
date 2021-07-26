# == Schema Information
#
# Table name: district_profiles
#
#  id                       :bigint           not null, primary key
#  city                     :string
#  county                   :string
#  daily_meals_number       :integer
#  district_name            :string           not null
#  enrolled_students_number :integer
#  production_sites_number  :integer
#  schools_number           :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  buyer_id                 :bigint           not null
#
# Indexes
#
#  index_district_profiles_on_buyer_id  (buyer_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => buyers.id)
#
require 'rails_helper'

RSpec.describe DistrictProfile, type: :model do
  subject(:district_profile) { FactoryBot.create(:district_profile) }

  it { is_expected.to belong_to(:buyer) }
  it { is_expected.to validate_presence_of(:district_name) }
end
