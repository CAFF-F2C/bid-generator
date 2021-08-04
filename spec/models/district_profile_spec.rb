require 'rails_helper'

RSpec.describe DistrictProfile, type: :model do
  subject(:district_profile) { FactoryBot.create(:district_profile) }

  it { is_expected.to belong_to(:buyer).inverse_of(:district_profile) }
  it { is_expected.to validate_presence_of(:district_name) }
end
