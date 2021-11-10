require 'rails_helper'

RSpec.describe Score, type: :model do
  subject(:rfp_score) { create(:score) }

  it { is_expected.to belong_to(:rfp) }
  it { is_expected.to belong_to(:score_category) }
  it { is_expected.to validate_presence_of(:rfp) }
  it { is_expected.to validate_presence_of(:score_category) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value).only_integer.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
  it { is_expected.to validate_uniqueness_of(:score_category_id).scoped_to(:rfp_id) }
end
