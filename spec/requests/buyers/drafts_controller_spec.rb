require 'rails_helper'

RSpec.describe Buyers::DraftsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'POST /create' do
    let(:buyer) { create(:buyer, :confirmed) }
    let(:procurement_type) { create(:procurement_type, name: 'TestType', published: true) }
    let(:rfp) { create(:rfp, buyer: buyer, start_year: 2012, procurement_type: procurement_type) }
    let(:location) { create(:location, buyer: buyer, street_address: '123 Main') }
    let(:score_category1) { create(:score_category, name: 'Cat1', position: 1, point_awarded_basis: 'point awarded basis', point_split_descriptions: 'point split description') }
    let(:score_category2) { create(:score_category, name: 'Cat2', position: 2, point_awarded_basis: 'point awarded basis', point_split_descriptions: 'point split description') }

    before do
      create(:district_profile, :complete, buyer: buyer)
      create(:delivery, rfp: rfp, location: location, delivery_days: [1, 2], deliveries_per_week: 2)
      create(:delivery, rfp: rfp, location: location, delivery_days: [2, 3], deliveries_per_week: 3)
      create(:score, rfp: rfp, score_category: score_category1, value: 60)
      create(:score, rfp: rfp, score_category: score_category2, value: 40)
      procurement_type.template.attach(io: File.open('spec/fixtures/files/RFP_Template.docx'), filename: 'RFP_Template.docx')
    end

    def make_request
      post buyers_rfp_draft_path(rfp)
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

      it 'creates a draft attachment' do
        make_request
        expect(rfp.reload.draft).to be_attached
      end
    end
  end
end
