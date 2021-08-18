require 'rails_helper'

RSpec.describe Buyers::LocationsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /index' do
    def make_request
      get buyers_district_profile_locations_path
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { create(:buyer, :confirmed) }

      before do
        sign_in buyer, scope: :buyer
      end

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end

      context 'when there is a location that belongs to the buyer' do
        before { create(:location, buyer: buyer, name: 'my location') }

        it 'shows the location' do
          make_request
          expect(page.find('main')).to have_content('my location')
        end
      end

      context 'when there is an rfp that does not belong to the buyer' do
        before { create(:location, name: 'my location') }

        it 'does not show the location' do
          make_request
          expect(page.find('main')).not_to have_content('my location')
        end
      end
    end
  end

  describe 'get #new' do
    def make_request
      get new_buyers_district_profile_location_path
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { create(:buyer, :confirmed) }

      before do
        sign_in buyer, scope: :buyer
      end

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end
    end
  end

  describe 'post #create' do
    def make_request(params = {})
      post buyers_district_profile_locations_path(location: params)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { create(:buyer, :confirmed) }

      before do
        sign_in buyer, scope: :buyer
      end

      it 'creates a new location' do
        expect { make_request(name: 'new location', street_address: '123 Main', city: 'city', state: 'state', zip_code: '12345') }.to change(Location, :count).by(1)
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

  describe 'get #edit' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:location) { create(:location, buyer: buyer) }

    def make_request
      get edit_buyers_district_profile_location_path(location)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before do
        sign_in buyer, scope: :buyer
      end

      context 'when the buyer owns the location' do
        it 'is successful' do
          make_request
          expect(response).to be_successful
        end
      end

      context 'when the buyer does not own the location' do
        let(:location) { create(:location) }

        it 'is not successful' do
          make_request
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'patch #update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:location) { create(:location, buyer: buyer) }

    def make_request(params = {})
      patch buyers_district_profile_location_path(location, location: params)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before do
        sign_in buyer, scope: :buyer
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
          make_request(city: '')
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'delete #destroy' do
    let(:buyer) { create(:buyer, :confirmed) }
    let!(:location) { create(:location, buyer: buyer, name: 'My location') }

    def make_request
      delete buyers_district_profile_location_path(location)
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before do
        sign_in buyer, scope: :buyer
      end

      it 'creates a new location' do
        expect { make_request }.to change(Location, :count).by(-1)
      end

      it 'redirect to the index' do
        make_request
        expect(response).to redirect_to(buyers_district_profile_locations_path)
      end
    end
  end
end
