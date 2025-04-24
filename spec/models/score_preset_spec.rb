require 'rails_helper'

RSpec.describe ScorePreset, type: :model do
  subject(:score_preset) { create(:score_preset, procurement_type: procurement_type) }

  let(:procurement_type) { create(:procurement_type) }

  it { is_expected.to validate_presence_of(:name) }

  describe '#category_value' do
    let(:category) { create(:score_category, procurement_types: [procurement_type]) }

    context 'when the preset value does not exist' do
      it 'returns zero' do
        expect(score_preset.category_value(category)).to eq(0)
      end
    end

    context 'when the preset value exists' do
      before { create(:score_preset_value, score_preset: score_preset, score_category: category, value: 5) }

      it 'returns the category value' do
        expect(score_preset.category_value(category)).to eq(5)
      end
    end
  end
end
