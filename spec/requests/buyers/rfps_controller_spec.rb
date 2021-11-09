require 'rails_helper'

RSpec.describe Buyers::RfpsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET #new' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

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

  describe 'POST #create' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }

    def make_request(params = {})
      post buyers_rfps_path(rfp: params)
    end

    def make_draft_request(params = {})
      post buyers_rfps_path(rfp: params, draft: true)
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request(bid_type: 'Produce', start_year: 1.year.from_now.year.to_s)
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before do
        sign_in buyer, scope: :buyer
      end

      it 'creates a new rfp' do
        expect do
          make_request(bid_type: 'Produce', start_year: 1.year.from_now.year.to_s)
        end.to change(Rfp, :count).by(1)
      end

      it 'sets the attributes' do
        make_request(bid_type: 'Produce', start_year: 1.year.from_now.year.to_s)
        expect(Rfp.last).to have_attributes(start_year: 1.year.from_now.year, bid_type: 'Produce')
      end

      it 'redirects to the scores page' do
        make_request(bid_type: 'Produce', start_year: 1.year.from_now.year.to_s)
        expect(response).to redirect_to(buyers_rfp_scores_path(Rfp.last))
      end

      context 'when creating a draft' do
        it 'redirects to the edit page' do
          make_draft_request(bid_type: 'Produce', start_year: 1.year.from_now.year.to_s)
          expect(response).to redirect_to(edit_buyers_rfp_path(Rfp.last))
        end
      end
    end
  end

  describe 'GET #show' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
    let(:rfp) { FactoryBot.create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

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
        FactoryBot.create(:district_profile, buyer: buyer)
        sign_in buyer, scope: :buyer
      end

      it 'renders the show page' do
        make_request
        expect(page).to have_content('2021 - 2022')
      end

      context 'when the rfp does not belong to the buyer' do
        let(:rfp) { FactoryBot.create(:rfp) }

        it 'redirects' do
          make_request
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'GET #edit' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
    let(:rfp) { FactoryBot.create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

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
      let(:rfp) { FactoryBot.create(:rfp) }

      it 'redirects' do
        make_request
        expect(response).to redirect_to(buyer_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
    let(:rfp) { FactoryBot.create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

    def make_request(rfp_id, params = {})
      patch buyers_rfp_path(rfp_id), params: {rfp: params}
    end

    def make_draft_request(rfp_id, params = {})
      patch buyers_rfp_path(rfp_id, draft: true), params: {rfp: params}
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request(-1)
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      before { sign_in(buyer, scope: :buyer) }

      it 'update the attributes' do
        make_request(rfp.id, start_year: 2023, bid_type: 'Produce')
        expect(Rfp.last).to have_attributes(start_year: 2023, bid_type: 'Produce')
      end

      it 'redirects to documents index page' do
        make_request(rfp.id, start_year: 2021, bid_type: 'Produce')
        expect(response).to redirect_to(buyers_rfp_scores_path(rfp))
      end

      context 'with missing information' do
        it 'sets a flash' do
          make_request(rfp.id, start_year: 2021, bid_type: '')
          expect(flash[:alert]).to include('RFP could not be saved')
        end
      end

      context 'when saving a draft' do
        it 'shows the scores form' do
          make_draft_request(rfp.id, start_year: 2021, bid_type: 'Produce')
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    def make_request(rfp_id)
      delete buyers_rfp_path(rfp_id)
    end

    context 'when no user is signed in' do
      it 'redirects to the sign in path' do
        make_request(-1)
        expect(response).to redirect_to(buyer_session_path)
      end
    end

    context 'when a buyer is signed in' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let!(:rfp) { FactoryBot.create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

      before { sign_in(buyer, scope: :buyer) }

      it 'is renders the index' do
        make_request(rfp.id)
        expect(response).to redirect_to buyers_documents_path
      end

      it 'deletes the rfp' do
        expect { make_request(rfp.id) }.to change(Rfp, :count).by(-1)
      end
    end

    context 'when the rfp does not belong to the buyer' do
      let(:buyer) { FactoryBot.create(:buyer, :confirmed) }
      let(:rfp) { FactoryBot.create(:rfp) }

      before { sign_in(buyer, scope: :buyer) }

      it 'redirects to the root path' do
        make_request(rfp.id)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
