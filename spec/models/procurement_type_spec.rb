require 'rails_helper'

RSpec.describe ProcurementType, type: :model do
  describe '#score_categories' do
    let(:procurement_type) { create(:procurement_type) }
    let(:score_category_1) { create(:score_category) }
    let(:score_category_2) { create(:score_category) }
    let(:score_category_3) { create(:score_category) }

    before do
      create(:procurement_type_score_category, procurement_type: procurement_type, score_category: score_category_1, position: 2)
      create(:procurement_type_score_category, procurement_type: procurement_type, score_category: score_category_2, position: 1)
      create(:procurement_type_score_category, procurement_type: procurement_type, score_category: score_category_3, position: 3)
    end

    it 'returns the ordered score categories' do
      expect(procurement_type.score_categories).to eq([score_category_2, score_category_1, score_category_3])
    end
  end
end
