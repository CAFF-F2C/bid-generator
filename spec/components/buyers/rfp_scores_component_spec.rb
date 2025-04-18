require 'rails_helper'

RSpec.describe Buyers::RfpScoresComponent, type: :component do
  let(:rfp) { create(:rfp) }
  let(:component) { described_class.new(current_rfp: rfp) }
  let!(:score_category1) { create(:score_category, name: 'Price', description: 'price description') }
  let!(:score_category2) { create(:score_category, name: 'Cat 2', description: 'cat 2 description') }
  let!(:score_category3) { create(:score_category, name: 'Cat 3', description: 'cat 3 description') }

  before do
    rfp.procurement_type.procurement_type_score_categories.create(score_category: score_category1, position: 0)
    rfp.procurement_type.procurement_type_score_categories.create(score_category: score_category2, position: 2)
    rfp.procurement_type.procurement_type_score_categories.create(score_category: score_category3, position: 3)
    rfp.procurement_type.procurement_type_score_categories.create(score_category: create(:score_category, name: 'Cat 4', description: 'cat 4 description'), position: 4)
  end

  context 'when the rfp has no scores' do
    it 'sets the first score to 100' do
      render_inline(component)
      expect(page.find("#score_category_#{score_category1.id}")).to have_field('score[value]', with: 100)
    end

    it 'sets other scores to zero' do
      render_inline(component)
      expect(page).to have_field('score[value]', with: 0)
    end

    it 'sets the total score to 100' do
      render_inline(component)
      expect(page.find('#rfp_total_score').text).to eq('Total: 100')
    end
  end

  context 'when the first score has been set' do
    before { create(:score, rfp: rfp, score_category: score_category1, value: 50) }

    it 'returns the score' do
      render_inline(component)
      expect(page.find("#score_category_#{score_category1.id}")).to have_field('score[value]', with: 50)
    end
  end

  context 'when the total score is greater than 100' do
    before do
      create(:score, rfp: rfp, score_category: score_category1, value: 60)
      create(:score, rfp: rfp, score_category: score_category2, value: 50)
    end

    it 'marks the total as having errors' do
      render_inline(component)
      expect(page.find('.form-errors__error').text).to include('Total must equal 100')
    end

    it 'mark scores as having errors' do
      render_inline(component)
      expect(page.find("#score_category_#{score_category1.id}")[:class]).to include('error')
    end
  end

  context 'when there are scores that are larger than the first score' do
    before do
      create(:score, rfp: rfp, score_category: score_category1, value: 30)
      create(:score, rfp: rfp, score_category: score_category2, value: 20)
      create(:score, rfp: rfp, score_category: score_category3, value: 50)
    end

    it 'marks the first score as having errors' do
      render_inline(component)
      expect(page.find("#score_category_#{score_category1.id}")[:class]).to include('error')
    end

    it 'marks the higher score as having errors' do
      render_inline(component)
      expect(page.find("#score_category_#{score_category3.id}")[:class]).to include('error')
    end
  end

  context 'when you save a score' do
    let(:score) { create(:score, rfp: rfp, score_category: score_category1, value: 50) }
    let(:component) { described_class.new(current_rfp: rfp, current_score: score) }

    it 'sets the focus on the saved score' do
      render_inline(component)
      expect(page.find("#score_value_#{score.score_category_id}")[:autofocus]).to be_present
    end
  end
end
