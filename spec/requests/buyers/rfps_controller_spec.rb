require 'rails_helper'

RSpec.describe Buyers::RfpsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /new' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request
      get new_buyers_rfp_path
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

      it 'renders the new page' do
        make_request
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /create' do
    let(:buyer) { create(:buyer, :confirmed) }

    def make_request
      post buyers_rfps_path
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
        it 'creates a new rfp' do
          expect { make_request }.to change(Rfp, :count).by(1)
        end

        it 'sets the attributes' do
          make_request
          expect(Rfp.last).to have_attributes(start_year: Time.current.year, bid_type: 'Produce')
        end

        it 'redirects the edit page' do
          make_request
          expect(response).to redirect_to edit_buyers_rfp_path(Rfp.last)
        end
      end
    end
  end

  describe 'GET /show' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

    def make_request
      get buyers_rfp_path(rfp)
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

      it 'renders the show page' do
        make_request
        expect(page).to have_content('2021 - 2022')
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

  describe 'GET /edit' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

    def make_request
      get edit_buyers_rfp_path(rfp)
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

      it 'is renders the edit page' do
        make_request
        expect(response).to be_successful
      end
    end

    context 'when the rfp does not belong to the buyer' do
      let(:rfp) { create(:rfp) }

      it 'redirects' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end
  end

  describe 'POST /update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

    def make_request(params = {})
      patch buyers_rfp_path(rfp, rfp: params, commit: 'Save and exit')
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
        it 'update the attributes' do
          make_request(start_year: 2023, bid_type: 'Produce')
          expect(Rfp.last).to have_attributes(start_year: 2023, bid_type: 'Produce')
        end

        it 'redirects to documents index page' do
          make_request(start_year: 2021, bid_type: 'Produce')
          expect(response).to redirect_to(buyers_documents_path)
        end
      end

      context 'with a incomplete profile' do
        it 'sets a flash' do
          make_request(start_year: 2021, bid_type: '')
          expect(flash[:alert]).to include("Bid type can't be blank")
        end
      end

      context 'when the buyer clicks next' do
        it 'shows the scores form' do
          patch buyers_rfp_path(rfp, rfp: {start_year: 2021, bid_type: 'Produce'}, commit: 'Next')
          expect(response).to redirect_to buyers_rfp_scores_path(Rfp.last)
        end
      end
    end
  end

  describe 'DELETE /delete' do
    let(:buyer) { create(:buyer, :confirmed) }
    let!(:rfp) { create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

    def make_request
      delete buyers_rfp_path(rfp)
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

      it 'is renders the index' do
        make_request
        expect(response).to redirect_to buyers_documents_path
      end

      it 'deletes the rfp' do
        expect { make_request }.to change(Rfp, :count).by(-1)
      end
    end

    context 'when the rfp does not belong to the buyer' do
      let(:rfp) { create(:rfp) }

      before do
        sign_in buyer, scope: :buyer
      end

      it 'redirects' do
        make_request
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
