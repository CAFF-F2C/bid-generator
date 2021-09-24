require 'rails_helper'

RSpec.describe Buyers::DistrictProfilesController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /show' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request
      get buyers_district_profile_path
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

      context 'when a buyer has no district profile' do
        it 'redirects to new district profile path' do
          make_request
          expect(response).to redirect_to(new_buyers_district_profile_path)
        end
      end

      context 'when buyer has a district profile' do
        before { FactoryBot.create(:district_profile, buyer: buyer, district_name: 'My District') }

        it 'is successful' do
          make_request
          expect(response).to be_successful
        end

        it 'renders the district profile show page' do
          make_request
          expect(page).to have_content('My District')
        end
      end
    end
  end

  describe 'GET /new' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request
      get new_buyers_district_profile_path
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

        it 'redirects to edit path' do
          make_request
          expect(response).to redirect_to(edit_buyers_district_profile_path)
        end
      end

      context 'when a buyer has no district profile' do
        it 'renders the district profile new page' do
          make_request
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'GET /edit' do
    let(:buyer) { create(:buyer, :confirmed) }

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

  describe 'POST /create' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request(params = {})
      post buyers_district_profile_path(district_profile: params)
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

      context 'with a complete profile' do
        it 'creates a new district profile' do
          expect { make_request(district_name: 'District name') }.to change(DistrictProfile, :count).by(1)
        end

        it 'shows successful flash message' do
          make_request(district_name: 'District name')
          expect(flash[:success]).to have_content(/success/i)
        end

        it 'sets the attributes' do
          make_request(district_name: 'My District', city: 'My City', county: 'My County', enrolled_students_number: 100)
          expect(DistrictProfile.last).to have_attributes(district_name: 'My District', city: 'My City', county: 'My County', enrolled_students_number: 100)
        end

        context 'when the buyer clicks save and exit' do
          it 'shows the profile' do
            post buyers_district_profile_path(district_profile: {district_name: 'District name'}, commit: 'Save and exit')
            expect(response).to redirect_to buyers_district_profile_path
          end
        end

        context 'when the buyer clicks next' do
          it 'shows the contact form' do
            post buyers_district_profile_path(district_profile: {district_name: 'District name'}, commit: 'Next')
            expect(response).to redirect_to edit_buyers_district_profile_contact_path
          end
        end
      end

      context 'with an incomplete profile' do
        it 'shows a flash message' do
          make_request(district_name: '')
          expect(flash[:alert]).to have_content(/could not be saved/i)
        end
      end
    end
  end

  describe 'PATCH /update' do
    def make_request(params = {})
      patch buyers_district_profile_path(district_profile: params)
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { create(:buyer, :confirmed) }

      before do
        sign_in buyer, scope: :buyer
      end

      context 'with a complete profile' do
        let!(:district_profile) { create(:district_profile, buyer: buyer, district_name: 'old name') }

        it 'updates the district profile' do
          expect { make_request(district_name: 'District name') }.to change { district_profile.reload.district_name }
        end

        it 'shows a successful flash message' do
          make_request(district_name: 'District name')
          expect(flash[:success]).to have_content(/updated/i)
        end

        context 'when the buyer clicks save and exit' do
          it 'shows the profile' do
            patch buyers_district_profile_path(district_profile: {district_name: 'District name'}, commit: 'Save and exit')
            expect(response).to redirect_to buyers_district_profile_path
          end
        end

        context 'when the buyer clicks next' do
          it 'shows the contact form' do
            patch buyers_district_profile_path(district_profile: {district_name: 'District name'}, commit: 'Next')
            expect(response).to redirect_to edit_buyers_district_profile_contact_path
          end
        end
      end

      context 'with an incomplete profile' do
        it 'shows a flash message' do
          make_request(district_name: '')
          expect(flash[:alert]).to have_content(/could not be saved/i)
        end
      end
    end
  end
end
