require 'rails_helper'

RSpec.describe Buyers::ScoresController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /index' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }

    describe 'when there are no score categories' do
      before do
        sign_in buyer, scope: :buyer
      end

      def make_request
        get buyers_rfp_scores_path(rfp)
      end

      it 'is successful' do
        make_request
        expect(response).to be_successful
      end
    end

    describe 'when there are score categories' do
      let!(:score_category1) { create(:score_category, name: 'Price', description: 'price description', position: 1) }

      before do
        create(:score_category, name: 'Cat 2', description: 'cat 2 description', position: 2)
        create(:score_category, name: 'Cat 3', description: 'cat 3 description', position: 3)
        create(:score_category, name: 'Cat 4', description: 'cat 4 description', position: 4)
      end

      def make_request
        get buyers_rfp_scores_path(rfp)
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

        context 'when the rfp has no scores' do
          it 'defaults the first score to 100' do
            make_request
            expect(page.find("#score_category_#{score_category1.id}")).to have_selector("input[name='score[value]'][value='100']")
          end

          it 'defaults the remaining scores to 0' do
            make_request
            expect(page).to have_selector("input[name='score[value]'][value='0']", count: 3)
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
  end

  describe 'POST /create' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let!(:score_category1) { create(:score_category, name: 'Price', description: 'price description', position: 1) }

    before do
      create(:score_category, name: 'Cat 2', description: 'cat 2 description', position: 2)
      create(:score_category, name: 'Cat 3', description: 'cat 3 description', position: 3)
      create(:score_category, name: 'Cat 4', description: 'cat 4 description', position: 4)
    end

    def make_request(params = {})
      post buyers_rfp_scores_path(rfp, score: params, headers: 'Accept: text/vnd.turbo-stream.html, text/html')
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

      it 'creates a new score' do
        expect { make_request(value: 20, score_category_id: score_category1.id) }.to change(Score, :count).by(1)
      end

      it 'returns turbo stream replacing score' do
        make_request(value: 20, score_category_id: score_category1.id)
        expect(response).to have_http_status(:ok)
        assert_select("turbo-stream[action='replace'][target='rfp_scores']", 1)
      end

      it 'returns the value for the new score' do
        make_request(value: 20, score_category_id: score_category1.id)
        assert_select "input[name='score[value]']:match('value', ?)", '20'
      end
    end
  end

  describe 'PATCH /update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let!(:score_category1) { create(:score_category, name: 'Price', description: 'price description', position: 1) }
    let!(:score) { create(:score, score_category: score_category1, rfp: rfp, value: 20) }

    before do
      create(:score_category, name: 'Cat 2', description: 'cat 2 description', position: 2)
      create(:score_category, name: 'Cat 3', description: 'cat 3 description', position: 3)
      create(:score_category, name: 'Cat 4', description: 'cat 4 description', position: 4)
    end

    def make_request(params = {})
      patch buyers_rfp_score_path(rfp, score, score: params, headers: 'Accept: text/vnd.turbo-stream.html, text/html')
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

      it 'updates the new score' do
        make_request(value: 50, score_category_id: score_category1.id)
        expect(score.reload.value).to eq(50)
      end

      it 'returns turbo stream replacing score' do
        make_request(value: 50, score_category_id: score_category1.id)
        expect(response).to have_http_status(:ok)
        assert_select("turbo-stream[action='replace'][target='rfp_scores']", 1)
      end

      it 'returns the value for the new score' do
        make_request(value: 50, score_category_id: score_category1.id)
        assert_select "input[name='score[value]']:match('value', ?)", '50'
      end
    end
  end
end
