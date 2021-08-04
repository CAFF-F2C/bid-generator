require 'rails_helper'

RSpec.describe Buyers::DocumentsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /index' do
    def make_request
      get buyers_documents_path
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

      context 'when there is an rfp that belongs to the buyer' do
        before { create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

        it 'shows the rfp' do
          make_request
          expect(page.find('main')).to have_content('Produce (2021 - 2022)')
        end
      end

      context 'when there is an rfp that does not belong to the buyer' do
        before { create(:rfp, start_year: 2021, bid_type: 'Produce') }

        it 'does not show the rfp' do
          make_request
          expect(page.find('main')).not_to have_content('Produce (2021 - 2022)')
        end
      end
    end
  end
end
