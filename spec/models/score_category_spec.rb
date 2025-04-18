require 'rails_helper'

RSpec.describe ScoreCategory, type: :model do
  subject(:score_category) { create(:score_category) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
end
