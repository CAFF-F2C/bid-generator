require 'rails_helper'

RSpec.describe Score, type: :model do
  subject(:rfp_score) { create(:rfp_score) }

  it { is_expected.to belong_to(:rfp) }
  it { is_expected.to belong_to(:score_category) }
  it { is_expected.to validate_presence_of(:rfp) }
  it { is_expected.to validate_presence_of(:score_category) }
  it { is_expected.to validate_presence_of(:value) }
end
