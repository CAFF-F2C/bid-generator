require 'rails_helper'

RSpec.describe Buyers::DeliveriesController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /index' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }

    def make_request
      get buyers_rfp_deliveries_path(rfp)
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

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end

      context 'when the rfp has no deliveries' do
        it 'is successful' do
          make_request
          expect(response).to be_successful
        end
      end

      context 'when the rfp has deliveries' do
        let(:location) { create(:location, name: 'Deliver here') }

        before do
          create(:delivery, rfp: rfp, location: location)
        end

        it 'lists the deliveries' do
          make_request
          expect(page).to have_content('Deliver here')
        end
      end

      context 'when the rfp does not belong to the buyer' do
        let(:rfp) { create(:rfp) }

        it 'redirects' do
          make_request
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'get #new' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }

    def make_request
      get new_buyers_rfp_delivery_path(rfp)
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

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end
    end
  end

  describe 'post #create' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let(:location) { create(:location, buyer: buyer) }

    def make_request(params = {})
      post buyers_rfp_deliveries_path(rfp, delivery: params)
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

      it 'creates a new delivery' do
        expect { make_request(location_id: location.id, window_start_time: 5, window_end_time: 6) }.to change(Delivery, :count).by(1)
      end

      it 'set the attributes on the new delivery' do
        make_request(location_id: location.id, deliveries_per_week: 2, delivery_days: ['1', '3'], window_start_time: 5, window_end_time: 6)
        expect(Delivery.last).to have_attributes(rfp: rfp, location: location, deliveries_per_week: 2, delivery_days: [1, 3], window_start_time: 5, window_end_time: 6)
      end

      it 'redirect to the index' do
        make_request(location_id: location.id, window_start_time: 5, window_end_time: 6)
        expect(response).to redirect_to(buyers_rfp_deliveries_path(rfp))
      end

      context 'with an incomplete delivery' do
        it 'renders new' do
          make_request(deliveries_per_week: 2, window_start_time: 5, window_end_time: 6)
          expect(flash[:alert]).to have_content(/could not be saved/i)
        end
      end
    end
  end

  describe 'get #edit' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let(:location) { create(:location, buyer: buyer) }
    let(:delivery) { create(:delivery, rfp: rfp, location: location) }

    def make_request
      get edit_buyers_rfp_delivery_path(rfp, delivery)
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

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end

      context 'when the buyer does not own the delivery' do
        let(:location) { create(:location) }
        let(:rfp) { create(:rfp) }

        it 'is not successful' do
          make_request
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'patch #update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let(:location) { create(:location, buyer: buyer) }
    let(:delivery) { create(:delivery, rfp: rfp, location: location) }

    def make_request(params = {})
      patch buyers_rfp_delivery_path(delivery, rfp_id: rfp.id), params: {delivery: params}
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

      it 'set the attributes on the delivery' do
        make_request(location_id: location.id, deliveries_per_week: 2, delivery_days: ['1', '3'], window_start_time: 5, window_end_time: 6)
        expect(Delivery.last).to have_attributes(rfp: rfp, location: location, deliveries_per_week: 2, delivery_days: [1, 3], window_start_time: 5, window_end_time: 6)
      end

      it 'redirect to the index' do
        make_request(location_id: location.id)
        expect(response).to redirect_to(buyers_rfp_deliveries_path(rfp))
      end

      context 'with an incomplete delivery' do
        it 'renders an alert' do
          make_request(location_id: '')
          expect(flash[:alert]).to have_content(/could not be saved/i)
        end
      end
    end
  end

  describe 'delete #destroy' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let(:location) { create(:location, buyer: buyer) }
    let!(:delivery) { create(:delivery, rfp: rfp, location: location) }

    def make_request
      delete buyers_rfp_delivery_path(delivery, rfp_id: rfp.id)
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

      it 'deletes the delivery' do
        expect { make_request }.to change(Delivery, :count).by(-1)
      end

      it 'redirect to the index' do
        make_request
        expect(response).to redirect_to(buyers_rfp_deliveries_path(rfp))
      end
    end
  end
end
