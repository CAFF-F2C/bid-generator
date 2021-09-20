require 'rails_helper'

RSpec.describe Buyers::FinalsController, type: :request do
  describe 'patch #update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let!(:rfp) { create(:rfp, buyer: buyer) }

    def make_request(params = {})
      patch buyers_rfp_final_path(rfp_id: rfp.id), params: {rfp: params}, headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
    end

    context 'when a buyer is not signed in' do
      it 'redirects' do
        make_request
        expect(response).to redirect_to(new_buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:final) { fixture_file_upload('final_rfp.txt', binary: true) }

      before do
        sign_in buyer, scope: :buyer
      end

      it 'set the reviwed file on the rfp' do
        make_request(final: final)
        expect(rfp.reload.final).to be_attached
      end
    end
  end
end
