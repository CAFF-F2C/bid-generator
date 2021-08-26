require 'rails_helper'

RSpec.describe Delivery, type: :model do
  subject(:delivery) { create(:delivery) }

  it { is_expected.to belong_to(:rfp).inverse_of(:deliveries) }
  it { is_expected.to belong_to(:location).inverse_of(:deliveries) }
  it { is_expected.to delegate_method(:name).to(:location).with_prefix }
  it { is_expected.to validate_presence_of(:location) }
  it { is_expected.to validate_presence_of(:rfp) }
  it { is_expected.to validate_inclusion_of(:delivery_days).in_array([*1..5]) }
end
