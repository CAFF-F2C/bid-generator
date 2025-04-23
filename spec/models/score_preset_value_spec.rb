require 'rails_helper'

RSpec.describe ScorePresetValue, type: :model do
  subject(:score_preset_value) { create(:score_preset_value, score_preset: score_preset, score_category: score_category) }

  let(:procurement_type) { create(:procurement_type) }
  let(:score_preset) { create(:score_preset, procurement_type: procurement_type) }
  let(:score_category) { procurement_type.score_categories.create(attributes_for(:score_category)) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value).only_integer.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
  it { is_expected.to validate_uniqueness_of(:score_category_id).scoped_to(:score_preset_id) }
end
