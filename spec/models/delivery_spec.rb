require 'rails_helper'

RSpec.describe Delivery, type: :model do
  subject(:delivery) { create(:delivery, window_start_time: 10, window_end_time: 11) }

  it { is_expected.to belong_to(:rfp).inverse_of(:deliveries) }
  it { is_expected.to belong_to(:location).inverse_of(:deliveries) }
  it { is_expected.to delegate_method(:name).to(:location).with_prefix }
  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_presence_of(:rfp) }
  it { is_expected.to validate_inclusion_of(:delivery_days).in_array([*1..5]) }
  it { is_expected.to validate_inclusion_of(:window_start_time).in_array([*4..15]) }
  it { is_expected.to validate_inclusion_of(:window_end_time).in_array([*4..15]) }

  describe 'validations' do
    describe 'window_end_time' do
      let(:delivery) { build(:delivery, window_start_time: 12, window_end_time: 10) }

      it 'must be larger than start time' do
        expect(delivery).not_to be_valid
      end
    end
  end
end
