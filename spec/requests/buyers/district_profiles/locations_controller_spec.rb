require 'rails_helper'

RSpec.describe Buyers::DistrictProfiles::LocationsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET #index' do
    def make_request
      get buyers_district_profile_locations_path
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer without a district profile is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before { sign_in(buyer, scope: :buyer) }

      it 'is successful' do
        make_request
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer has a district profile' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end

      context 'when there is a location that belongs to the buyer' do
        before { FactoryBot.create(:location, buyer: buyer, name: 'my location') }

        it 'shows the location' do
          make_request
          expect(page.find('main')).to have_content('my location')
        end
      end

      context 'when there is an rfp that does not belong to the buyer' do
        before { FactoryBot.create(:location, name: 'my location') }

        it 'does not show the location' do
          make_request
          expect(page.find('main')).not_to have_content('my location')
        end
      end
    end
  end

  describe 'GET #new' do
    def make_request
      get new_buyers_district_profile_location_path
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer without a district profile is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before { sign_in(buyer, scope: :buyer) }

      it 'is successful' do
        make_request
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer has a district profile' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'is successful' do
        make_request
        expect(page).to have_field('Name').and have_field('Street address').and have_field('City').and have_field('State').and have_field('ZIP code')
      end
    end
  end

  describe 'POST #create' do
    def make_request(params = {})
      post buyers_district_profile_locations_path(location: params)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer without a district profile is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before { sign_in(buyer, scope: :buyer) }

      it 'bounces back to editing the district profile' do
        make_request(name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer has a district profile' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'creates a new location' do
        expect do
          make_request(name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
        end.to change(Location, :count).by(1)
      end

      it 'set the attributes on the new location' do
        make_request(name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
        expect(Location.last).to have_attributes(buyer: buyer, name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
      end

      it 'redirect to the index' do
        make_request(name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
        expect(response).to redirect_to(buyers_district_profile_locations_path)
      end

      context 'with an incomplete location' do
        it 'renders new' do
          make_request(city: 'city', state: 'state', zip_code: '12345')
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'GET #edit' do
    def make_request(location_id)
      get edit_buyers_district_profile_location_path(location_id)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request(-1)
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer without a district profile is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location, buyer: buyer) }

      before { sign_in(buyer, scope: :buyer) }

      it 'bounces back to editing the district profile' do
        make_request(location.id)
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer has a district profile' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location, buyer: buyer) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'is successful' do
        make_request(location.id)
        expect(page).to have_field('Name').and have_field('Street address').and have_field('City').and have_field('State').and have_field('ZIP code')
      end
    end

    context 'when the buyer does not own the location' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'bounces back to the root path' do
        make_request(location.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    def make_request(location_id, params = {})
      patch buyers_district_profile_location_path(location_id), params: {location: params}
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request(-1)
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer without a district profile is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location, buyer: buyer) }

      before { sign_in(buyer, scope: :buyer) }

      it 'bounces back to editing the district profile' do
        make_request(location.id)
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location, buyer: buyer) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'set the attributes on the new location' do
        make_request(location.id, name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
        expect(Location.last).to have_attributes(buyer: buyer, name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
      end

      it 'redirect to the index' do
        make_request(location.id, name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345')
        expect(response).to redirect_to(buyers_district_profile_locations_path)
      end

      context 'with an incomplete location' do
        it 'renders new' do
          make_request(location.id, city: '')
          expect(response).to be_successful
        end
      end
    end

    context 'when the buyer does not own the location' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'bounces back to the root path' do
        make_request(location.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    def make_request(location_id)
      delete buyers_district_profile_location_path(location_id)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request(-1)
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer without a district profile is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location, buyer: buyer) }

      before { sign_in(buyer, scope: :buyer) }

      it 'bounces back to editing the district profile' do
        make_request(location.id)
        expect(response).to redirect_to(edit_buyers_district_profile_path)
      end
    end

    context 'when a buyer has a district profile' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let!(:location) { FactoryBot.create(:location, buyer: buyer, name: 'My location') }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'deletes the location' do
        expect do
          make_request(location.id)
        end.to change(Location, :count).by(-1)
      end

      it 'redirect to the index' do
        make_request(location.id)
        expect(response).to redirect_to(buyers_district_profile_locations_path)
      end
    end

    context 'when the buyer does not own the location' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:location) { FactoryBot.create(:location) }

      before do
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in(buyer, scope: :buyer)
      end

      it 'bounces back to the root path' do
        make_request(location.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
