require 'rails_helper'

RSpec.describe DistrictProfile, type: :model do
  subject(:district_profile) { FactoryBot.create(:district_profile, :complete, buyer: buyer) }

  let(:buyer) { FactoryBot.create(:buyer) }

  it { is_expected.to belong_to(:buyer).inverse_of(:district_profile) }

  it { is_expected.to validate_presence_of(:district_name).on(:district_information) }
  it { is_expected.to validate_presence_of(:city).on(:district_information) }
  it { is_expected.to validate_presence_of(:county).on(:district_information) }
  it { is_expected.to validate_numericality_of(:enrolled_students_number).on(:district_information) }

  it { is_expected.to validate_presence_of(:contact_full_name).on(:rfp_contact) }
  it { is_expected.to validate_presence_of(:contact_department_name).on(:rfp_contact) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_city).on(:rfp_contact) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_state).on(:rfp_contact) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_street).on(:rfp_contact) }
  it { is_expected.to validate_presence_of(:contact_mailing_address_zip).on(:rfp_contact) }
  it { is_expected.to validate_presence_of(:contact_phone_number).on(:rfp_contact) }

  it { is_expected.to validate_presence_of(:local_percentage).on(:procurement_terms) }
  it { is_expected.to validate_presence_of(:required_insurance_aggregate).on(:procurement_terms) }
  it { is_expected.to validate_presence_of(:required_insurance_automobile).on(:procurement_terms) }
  it { is_expected.to validate_presence_of(:required_insurance_per_incident).on(:procurement_terms) }

  describe '#complete?' do
    context 'when there are no locations' do
      it { is_expected.not_to be_complete }
    end

    context 'when there are locations' do
      before { FactoryBot.create(:location, buyer: buyer) }

      it { is_expected.to be_complete }
    end
  end
end
