require 'rails_helper'

RSpec.describe Buyers::DistrictProfilesController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET #show' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

    def make_request
      get buyers_district_profile_path
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer does not have a district profile' do
      before { sign_in(buyer, scope: :buyer) }

      it 'redirects to the district profile edit path' do
        make_request
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer has a complete district profile' do
      before do
        FactoryBot.create(:district_profile, :complete, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end

      it 'renders the district profile' do
        make_request
        expect(page).to have_content('District name')
      end
    end
  end

  describe 'GET #edit' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

    def make_request
      get edit_buyers_district_profile_path
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before { sign_in(buyer, scope: :buyer) }

      it 'renders edit page' do
        make_request
        expect(response).to be_successful
      end

      it 'renders all necessary form fields' do
        make_request
        expect(page)
          .to have_field('District name')
          .and have_field('City')
          .and have_field('County')
          .and have_field('Number of enrolled students')
      end
    end
  end

  describe 'PATCH #update' do
    def make_request(params = {})
      patch buyers_district_profile_path(district_profile: params)
    end

    def make_draft_request(params = {})
      patch buyers_district_profile_path(district_profile: params, draft: true)
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before { sign_in(buyer, scope: :buyer) }

      context 'with a complete profile' do
        let!(:district_profile) { FactoryBot.create(:district_profile, buyer: buyer, district_name: 'old name') }

        it 'updates the district profile' do
          expect do
            make_request(district_name: 'District name')
          end.to change { district_profile.reload.district_name }.to('District name')
        end

        context 'when saving a draft' do
          it 'renders the form' do
            make_draft_request(district_name: 'District name')
            expect(page).to have_field('District name')
          end
        end

        context 'when the buyer clicks next' do
          it 'redirects to the contact page' do
            make_request(district_name: 'District name')
            expect(response).to redirect_to edit_buyers_district_profile_contact_path
          end
        end
      end
    end
  end
end
