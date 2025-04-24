require 'rails_helper'

RSpec.describe Buyers::ScorePresetsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET /show' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }

    let(:preset) { create(:score_preset, procurement_type: rfp.procurement_type) }
    let(:price) { create(:score_category, name: 'Price', description: 'price description') }
    let(:cat4) { create(:score_category, name: 'Cat 4', description: 'cat 4 description') }
    let(:cat3) { create(:score_category, name: 'Cat 3', description: 'cat 3 description') }
    let(:cat2) { create(:score_category, name: 'Cat 2', description: 'cat 2 description') }

    before do
      rfp.procurement_type.procurement_type_score_categories.create(score_category: price, position: 0)
      rfp.procurement_type.procurement_type_score_categories.create(score_category: cat4, position: 4)
      rfp.procurement_type.procurement_type_score_categories.create(score_category: cat3, position: 3)
      rfp.procurement_type.procurement_type_score_categories.create(score_category: cat2, position: 2)

      create(:score_preset_value, score_preset: preset, score_category: price, value: 55)
      create(:score_preset_value, score_preset: preset, score_category: cat3, value: 25)
      create(:score_preset_value, score_preset: preset, score_category: cat4, value: 1)

      create(:score, rfp: rfp, score_category: price, value: 30)
      create(:score, rfp: rfp, score_category: cat3, value: 27)
      create(:score, rfp: rfp, score_category: cat4, value: 1)
    end

    def make_request
      get buyers_rfp_score_preset_path(rfp, preset)
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

      it 'shows suggested values' do
        make_request
        expect(page.find("#score_category_#{price.id}")).to have_content('Price').and have_content('30').and have_content('55').and have_content('25')
        expect(page.find("#score_category_#{cat3.id}")).to have_content('Cat 3').and have_content('27').and have_content('25').and have_content('2')
        expect(page.find("#score_category_#{cat4.id}")).to have_content('Cat 4').and have_content('1')
        expect(page.find("#score_category_#{cat2.id}")).to have_content('Cat 2').and have_content('0')
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

  describe 'PATCH /update' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:rfp) { create(:rfp, buyer: buyer) }
    let(:preset) { create(:score_preset, procurement_type: rfp.procurement_type) }
    let(:price) { create(:score_category, name: 'Price') }
    let(:cat4) { create(:score_category, name: 'Cat 4') }
    let(:cat3) { create(:score_category, name: 'Cat 3') }
    let(:cat2) { create(:score_category, name: 'Cat 2') }

    before do
      rfp.procurement_type.procurement_type_score_categories.create(score_category: price, position: 0)
      rfp.procurement_type.procurement_type_score_categories.create(score_category: cat4, position: 4)
      rfp.procurement_type.procurement_type_score_categories.create(score_category: cat3, position: 3)
      rfp.procurement_type.procurement_type_score_categories.create(score_category: cat2, position: 2)

      create(:score_preset_value, score_preset: preset, score_category: price, value: 55)
      create(:score_preset_value, score_preset: preset, score_category: cat3, value: 25)
      create(:score_preset_value, score_preset: preset, score_category: cat4, value: 1)
    end

    def make_request
      patch buyers_rfp_score_preset_path(rfp, preset)
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

      context 'when there are no scores' do
        it 'creates the scores' do
          make_request
          expect(rfp.scores.collect(&:value)).to eq([55, 25, 1])
        end

        it 'redirects to the score sheet' do
          make_request
          expect(response).to redirect_to(buyers_rfp_scores_path(rfp))
        end
      end

      context 'when there are already scores' do
        before do
          create(:score, rfp: rfp, score_category: price, value: 30)
          create(:score, rfp: rfp, score_category: cat3, value: 27)
          create(:score, rfp: rfp, score_category: cat4, value: 1)
        end

        it 'updates the scores' do
          make_request
          expect(rfp.scores.collect(&:value)).to eq([55, 25, 1])
        end

        it 'redirects to the score sheet' do
          make_request
          expect(response).to redirect_to(buyers_rfp_scores_path(rfp))
        end
      end
    end
  end
end
