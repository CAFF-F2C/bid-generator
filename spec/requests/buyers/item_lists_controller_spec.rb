require 'rails_helper'

RSpec.describe Buyers::ItemListsController, type: :request do
  describe 'GET /edit' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }

    def make_request
      get edit_buyers_rfp_item_list_path(rfp)
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

      it 'renders edit page' do
        make_request
        expect(response).to be_successful
      end

      context 'when the buyer does not own the rfp' do
        let(:rfp) { create(:rfp) }

        it 'redirects to root' do
          make_request
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'patch #update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let!(:rfp) { create(:rfp, buyer: buyer) }

    def make_request(params = {})
      patch buyers_rfp_item_list_path(rfp_id: rfp.id), params: {rfp: params}, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:item_list) { fixture_file_upload('test.png', 'image/png', binary: true) }

      before do
        sign_in buyer, scope: :buyer
      end

      it 'set the item list file on the rfp' do
        make_request(item_list: item_list)
        expect(rfp.reload.item_list).to be_attached
      end
    end
  end
end
