require 'rails_helper'

RSpec.describe RfpStatusComponent, type: :component do
  let(:buyer) { create(:buyer) }
  let(:location) { create(:location, buyer: buyer) }
  let(:rfp) { create(:rfp, buyer: buyer) }
  let(:score_category) { create(:score_category) }

  let(:component) { described_class.new(rfp: rfp) }

  before do
    create(:district_profile, :complete, buyer: buyer)
  end

  context 'when the rfp is not complete' do
    it 'shows the status as in progress' do
      render_inline(component)
      expect(page).to have_content(/in progress/i)
    end

    it 'sets the class on the status' do
      render_inline(component)
      expect(page).to have_selector('.rfp-status__document-status--in-progress')
    end
  end

  context 'when the rfp is complete' do
    let(:rfp) { create(:rfp, buyer: buyer) }
    let(:district_profile) { create(:district_profile, :complete, buyer: buyer) }

    before do
      create(:score, score_category: score_category, rfp: rfp, value: 100)
      rfp.item_list.attach(io: File.open('spec/fixtures/files/item_list.txt'), filename: 'item_list.txt')
      create(:delivery, location: location, rfp: rfp)
    end

    it 'shows the status as complete' do
      render_inline(component)
      expect(page).to have_content(/complete/i)
    end

    it 'sets the class on the status' do
      render_inline(component)
      expect(page).to have_selector('.rfp-status__document-status--complete')
    end

    context 'when the rfp has a downloaded rfp' do
      before do
        rfp.draft.attach(io: File.open('spec/fixtures/files/item_list.txt'), filename: 'draft_rfp.txt')
      end

      it 'shows the status as draft' do
        render_inline(component)
        expect(page).to have_content(/draft/i)
      end

      it 'sets the class on the status' do
        render_inline(component)
        expect(page).to have_selector('.rfp-status__document-status--draft')
      end
    end

    context 'when the rfp has a uploaded reviewed rfp' do
      before do
        rfp.reviewed.attach(io: File.open('spec/fixtures/files/reviewed_rfp.txt'), filename: 'reviewed_rfp.txt')
      end

      it 'shows the status as review' do
        render_inline(component)
        expect(page).to have_content(/review/i)
      end

      it 'sets the class on the status' do
        render_inline(component)
        expect(page).to have_selector('.rfp-status__document-status--review')
      end
    end

    context 'when the rfp has a uploaded final rfp' do
      before do
        rfp.final.attach(io: File.open('spec/fixtures/files/final_rfp.txt'), filename: 'final_rfp.txt')
      end

      it 'shows the status as final' do
        render_inline(component)
        expect(page).to have_content(/final/i)
      end

      it 'sets the class on the status' do
        render_inline(component)
        expect(page).to have_selector('.rfp-status__document-status--final')
      end
    end
  end
end
