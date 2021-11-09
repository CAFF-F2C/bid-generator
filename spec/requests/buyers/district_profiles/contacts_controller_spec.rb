require 'rails_helper'

RSpec.describe Buyers::DistrictProfiles::ContactsController, type: :request do
  describe 'GET /edit' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request
      get edit_buyers_district_profile_contact_path
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
        it 'renders the district profile edit page' do
          make_request
          expect(response).to redirect_to(edit_buyers_district_profile_path)
        end
      end
    end
  end

  describe 'PATCH /update' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request(params = {})
      patch buyers_district_profile_contact_path(district_profile: params)
    end

    def make_draft_request(params = {})
      patch buyers_district_profile_contact_path(district_profile: params, draft: true)
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
          contact_full_name: 'FS Director',
          contact_mailing_address_city: 'city',
          contact_department_name: 'department',
          contact_mailing_address_state: 'state',
          contact_mailing_address_street: 'street',
          contact_mailing_address_zip: 'zip',
          contact_phone_number: '5551234567',
          contact_title: 'title'
        )
        expect(buyer.district_profile).to have_attributes(
          contact_full_name: 'FS Director',
          contact_mailing_address_city: 'city',
          contact_department_name: 'department',
          contact_mailing_address_state: 'state',
          contact_mailing_address_street: 'street',
          contact_mailing_address_zip: 'zip',
          contact_phone_number: '5551234567',
          contact_title: 'title'
        )
      end

      it 'shows a successful flash message' do
        make_request(contact_full_name: 'FS Director')
        expect(flash[:success]).to have_content(/updated/i)
      end

      context 'when the buyer clicks save draft' do
        it 'renders the edit page' do
          make_draft_request(contact_full_name: 'FS Director')
          expect(response).to be_successful
        end
      end

      context 'when the buyer clicks next' do
        it 'shows the profile' do
          make_request(contact_full_name: 'FS Director')
          expect(response).to redirect_to(edit_buyers_district_profile_procurement_path)
        end
      end
    end
  end
end
