require 'rails_helper'

RSpec.describe "Buyers::DistrictProfiles", type: :request do
  describe "GET /new" do
    def make_request
      get new_buyers_district_profile_path
    end

    let(:buyer) { create(:buyer) }

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

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end
    end
  end
end
