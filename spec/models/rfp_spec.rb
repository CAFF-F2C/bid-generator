# == Schema Information
#
# Table name: rfps
#
#  id         :bigint           not null, primary key
#  bid_type   :integer          not null
#  start_year :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  buyer_id   :bigint           not null
#
# Indexes
#
#  index_rfps_on_buyer_id  (buyer_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => buyers.id)
#
require 'rails_helper'

RSpec.describe Rfp, type: :model do
  subject(:rfp) { create(:rfp, start_year: 2021, bid_type: 'Produce') }

  it { is_expected.to belong_to(:buyer).inverse_of(:rfps) }
  it { is_expected.to have_many(:scores).inverse_of(:rfp) }
  it { is_expected.to validate_presence_of(:bid_type) }
  it { is_expected.to validate_presence_of(:start_year) }
  it { is_expected.to validate_presence_of(:buyer) }
  it { is_expected.to define_enum_for(:bid_type).with_values(described_class::BID_TYPES) }

  describe '#name' do
    it 'builds the name from year and type' do
      expect(rfp.name).to eq('Produce (2021 - 2022)')
    end
  end

  describe '#school_year' do
    it 'builds the school year to current and next year' do
      expect(rfp.school_year).to eq('2021 - 2022')
    end
  end
end
