require 'rails_helper'

RSpec.describe ScorePreset, type: :model do
  subject(:score_preset) { create(:score_preset) }

  it { is_expected.to validate_presence_of(:name) }
end
