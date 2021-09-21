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

require 'rails_helper'

RSpec.describe Rfp, type: :model do
  subject(:rfp) { create(:rfp, buyer: buyer, start_year: 2021, bid_type: 'Produce') }

  let(:buyer) { create(:buyer) }

  it { is_expected.to belong_to(:buyer).inverse_of(:rfps) }
  it { is_expected.to have_many(:scores).inverse_of(:rfp) }
  it { is_expected.to have_many(:deliveries).inverse_of(:rfp) }
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

  describe '#positive_scores' do
    let(:zero_score) { create(:score, rfp: rfp, value: 0) }
    let(:positive_score) { create(:score, rfp: rfp, value: 20) }

    it 'returns the postive scores' do
      expect(rfp.positive_scores).to eq([positive_score])
    end
  end

  describe 'complete?' do
    context 'when the rfp is not complete' do
      it 'is not complete' do
        expect(rfp).not_to be_complete
      end
    end

    context 'when the rfp is complete' do
      let(:location) { create(:location, buyer: buyer) }

      before do
        create(:district_profile, :complete, buyer: buyer)
        create(:score, rfp: rfp, value: 100)
        create(:delivery, location: location, rfp: rfp)
      end

      it 'is complete' do
        expect(rfp).to be_complete
      end
    end
  end

  describe '#status' do
    let(:score_category) { create(:score_category) }
    let(:location) { create(:location, buyer: buyer) }

    context 'when the rfp is not complete' do
      it 'shows the status as in progress' do
        expect(rfp.status).to eq(:in_progress)
      end
    end

    context 'when the rfp is complete' do
      let(:rfp) { create(:rfp, buyer: buyer) }

      before do
        create(:district_profile, :complete, buyer: buyer)
        create(:score, score_category: score_category, rfp: rfp, value: 100)
        rfp.item_list.attach(io: File.open('spec/fixtures/files/item_list.txt'), filename: 'item_list.txt')
        create(:delivery, location: location, rfp: rfp)
      end

      it 'shows the status as complete' do
        expect(rfp.status).to eq(:complete)
      end

      context 'when the rfp has a downloaded rfp' do
        before do
          rfp.draft.attach(io: File.open('spec/fixtures/files/item_list.txt'), filename: 'draft_rfp.txt')
        end

        it 'shows the status as draft' do
          expect(rfp.status).to eq(:draft)
        end
      end

      context 'when the rfp has a uploaded reviewed rfp' do
        before do
          rfp.reviewed.attach(io: File.open('spec/fixtures/files/reviewed_rfp.txt'), filename: 'reviewed_rfp.txt')
        end

        it 'shows the status as review' do
          expect(rfp.status).to eq(:review)
        end
      end

      context 'when the rfp has a uploaded final rfp' do
        before do
          rfp.final.attach(io: File.open('spec/fixtures/files/final_rfp.txt'), filename: 'final_rfp.txt')
        end

        it 'shows the status as final' do
          expect(rfp.status).to eq(:final)
        end
      end
    end
  end
end
