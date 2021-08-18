require 'rails_helper'

RSpec.describe Buyers::ProcurementsController, type: :request do
  describe 'GET /edit' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request
      get edit_buyers_district_profile_procurement_path
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before do
        sign_in buyer, scope: :buyer
      end

      context 'when buyer has a district profile' do
        before { FactoryBot.create(:district_profile, buyer: buyer, district_name: 'My District') }

        it 'renders edit page' do
          make_request
          expect(response).to be_successful
        end
      end

      context 'when a buyer has no district profile' do
        it 'renders the district profile new page' do
          make_request
          expect(response).to redirect_to(new_buyers_district_profile_path)
        end
      end
    end
  end

  describe 'PATCH /update' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request(params = {})
      patch buyers_district_profile_procurement_path(district_profile: params)
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before do
        create(:district_profile, buyer: buyer, district_name: 'District Name')
        sign_in buyer, scope: :buyer
      end

      it 'updates the district profile contact information' do
        make_request(
          local_percentage: '25',
          price_verified: 'false',
          allow_piggyback: 'true',
          required_insurance_aggregate: '1_000_000',
          required_insurance_automobile: '2_000_000',
          required_insurance_per_incident: '500_000'
        )
        expect(buyer.district_profile).to have_attributes(
          local_percentage: 25,
          price_verified: false,
          allow_piggyback: true,
          required_insurance_aggregate: 1_000_000,
          required_insurance_automobile: 2_000_000,
          required_insurance_per_incident: 500_000
        )
      end

      it 'shows a successful flash message' do
        make_request(contact_full_name: 'FS Director')
        expect(flash[:success]).to have_content(/updated/i)
      end

      context 'when the buyer clicks save and exit' do
        it 'shows the profile' do
          patch buyers_district_profile_procurement_path(district_profile: {contact_full_name: 'FS Director'}, commit: 'Save and exit')
          expect(response).to redirect_to buyers_district_profile_path
        end
      end

      context 'when the buyer clicks next' do
        it 'shows the profile' do
          patch buyers_district_profile_procurement_path(district_profile: {contact_full_name: 'FS Director'}, commit: 'Next')
          expect(response).to redirect_to buyers_district_profile_locations_path
        end
      end
    end
  end
end
