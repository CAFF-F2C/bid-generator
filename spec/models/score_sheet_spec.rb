require 'rails_helper'

RSpec.describe ScoreSheet, type: :model do
  subject(:score_sheet) { described_class.new(rfp: rfp) }

  let(:rfp) { create(:rfp) }

  describe '#find_or_initialize_scores' do
    context 'when there are not score categories' do
      it 'is empty' do
        expect(score_sheet.find_or_initialize_scores).to eq([])
      end
    end

    context 'when the RFP has no scores' do
      before do
        create(:score_category, name: 'Price', position: 0)
        create(:score_category, name: 'Cat', position: 1)
      end

      it 'sets the first score to 100' do
        expect(score_sheet.find_or_initialize_scores.first).to have_attributes({rfp_id: rfp.id, value: 100})
      end

      it 'sets the remaining scores to zero' do
        expect(score_sheet.find_or_initialize_scores.second).to have_attributes({rfp_id: rfp.id, value: 0})
      end
    end

    context 'when the rfp has a score' do
      let(:cat) { create(:score_category, name: 'Cat', position: 1) }
      let!(:score) { create(:score, rfp: rfp, score_category: cat, value: 25) }

      before do
        create(:score_category, name: 'Price', position: 0)
      end

      it 'returns the score' do
        expect(score_sheet.find_or_initialize_scores.second).to eq(score)
      end
    end
  end

  describe '#errors' do
    let!(:score_category1) { create(:score_category, name: 'Price', description: 'price description', position: 1) }
    let!(:score_category2) { create(:score_category, name: 'Cat 2', description: 'cat 2 description', position: 2) }

    context 'when there are no scores' do
      it 'is not valid' do
        expect(score_sheet.valid?).to eq(false)
      end

      it 'returns an error' do
        score_sheet.valid?
        expect(score_sheet.errors.full_messages).to include("Positive scores can't be blank")
      end
    end

    context 'when there is a score of zero' do
      before do
        create(:score, rfp: rfp, score_category: score_category1, value: 0)
      end

      it 'returns an error' do
        score_sheet.valid?
        expect(score_sheet.errors.full_messages).to include("Positive scores can't be blank")
      end
    end

    context 'when the score sheet is valid' do
      before do
        create(:score, rfp: rfp, score_category: score_category1, value: 60)
        create(:score, rfp: rfp, score_category: score_category2, value: 40)
      end

      it 'returns no errors' do
        score_sheet.valid?
        expect(score_sheet.errors).to be_blank
      end
    end

    context 'when the scores do not add up to 100' do
      before do
        create(:score, rfp: rfp, score_category: score_category1, value: 60)
        create(:score, rfp: rfp, score_category: score_category2, value: 50)
      end

      it 'returns errors on base' do
        score_sheet.valid?
        expect(score_sheet.errors.where(:base).first.full_message).to eq('Total must equal 100')
      end
    end

    context 'when there are scores that are larger than the first score' do
      before do
        create(:score, rfp: rfp, score_category: score_category1, value: 40)
        create(:score, rfp: rfp, score_category: score_category2, value: 60)
      end

      it 'returns errors on base' do
        score_sheet.valid?
        expect(score_sheet.errors.where(:base).first.full_message).to include('Price must be the highest score')
      end

      it 'marks the first score as having errors' do
        score_sheet.valid?
        expect(score_sheet.scores.first.errors.full_messages).to include('Price must be the highest score')
      end

      it 'marks the higher score as having errors' do
        score_sheet.valid?
        expect(score_sheet.scores.second.errors.full_messages).to include('Price must be the highest score')
      end
    end
  end
end
