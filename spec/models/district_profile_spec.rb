require 'rails_helper'

RSpec.describe DistrictProfile, type: :model do
  subject(:district_profile) { FactoryBot.create(:district_profile) }

  it { is_expected.to belong_to(:buyer).inverse_of(:district_profile) }
  it { is_expected.to validate_presence_of(:district_name) }

  it { is_expected.to validate_presence_of(:city).on(:complete?) }
  it { is_expected.to validate_presence_of(:county).on(:complete?) }

  it { is_expected.to validate_presence_of(:contact_full_name).on(:complete?) }
  it { is_expected.to validate_presence_of(:contact_department_name).on(:complete?) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_city).on(:complete?) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_state).on(:complete?) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_street).on(:complete?) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_zip).on(:complete?) }
  it { is_expected.to validate_presence_of(:contact_phone_number).on(:complete?) }

  it { is_expected.to validate_presence_of(:local_percentage).on(:complete?) }
  it { is_expected.to validate_presence_of(:required_insurance_aggregate).on(:complete?) }
  it { is_expected.to validate_presence_of(:required_insurance_automobile).on(:complete?) }

  describe 'locations complete?' do
    context 'when there are no locations' do
      it 'is not complete' do
        expect(district_profile).not_to be_complete
      end
    end

    context 'when there are locations' do
      let(:buyer) { create(:buyer) }
      let(:district_profile) { FactoryBot.create(:district_profile, :complete, buyer: buyer) }

      before { create(:location, buyer: buyer) }

      it 'is complete' do
        expect(district_profile).to be_complete
      end
    end
  end
end
