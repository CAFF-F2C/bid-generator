require 'rails_helper'

RSpec.describe RfpCompositor do
  subject(:compositor) { described_class.new(rfp) }

  let(:buyer) { create(:buyer) }
  let(:procurement_type) { create(:procurement_type, name: 'TestType', published: true) }
  let(:rfp) { create(:rfp, buyer: buyer, start_year: 2012, procurement_type: procurement_type) }
  let(:location) { create(:location, buyer: buyer, street_address: '123 Main') }
  let(:score_category1) { create(:score_category, name: 'Cat1', position: 1, point_awarded_basis: 'point awarded basis', point_split_descriptions: 'point split description', vendor_questions: 'Cat1 vendor question') }
  let(:score_category2) { create(:score_category, name: 'Cat2', position: 2, point_awarded_basis: 'point awarded basis', point_split_descriptions: 'point split description', vendor_questions: 'Cat2 vendor question') }

  context 'when the rfp is not valid' do
    it 'is not valid' do
      expect(compositor.valid?).to be(false)
    end

    it 'returns false' do
      expect(compositor.attach).to be(false)
    end

    it 'does not attach the generated rfp' do
      compositor.attach
      expect(rfp.reload.draft).not_to be_attached
    end
  end

  context 'when the rfp is valid' do
    before do
      create(:district_profile, :complete, buyer: buyer)
      create(:delivery, rfp: rfp, location: location, delivery_days: [1, 2], deliveries_per_week: 2)
      create(:delivery, rfp: rfp, location: location, delivery_days: [2, 3], deliveries_per_week: 3)
      create(:score, rfp: rfp, score_category: score_category1, value: 60)
      create(:score, rfp: rfp, score_category: score_category2, value: 40)
      procurement_type.template.attach(io: File.open('spec/fixtures/files/RFP_Template.docx'), filename: 'RFP_Template.docx')
    end

    it 'is valid' do
      expect(compositor.valid?).to be(true)
    end

    it 'returns true' do
      expect(compositor.attach).to be(true)
    end

    it 'attaches the generated rfp' do
      compositor.attach
      expect(rfp.reload.draft).to be_attached
    end

    it 'calculates the case_demonstrated_price_start' do
      travel_to Date.new(2012) do
        expect(compositor.context[:case_demonstrated_price_start]).to eq('November 2011')
      end
    end

    it 'calculates the case_demonstrated_price_end' do
      travel_to Date.new(2012) do
        expect(compositor.context[:case_demonstrated_price_end]).to eq('July 2011')
      end
    end

    it 'calculates the price_period_start' do
      expect(compositor.context[:price_period_start]).to eq('July 1, 2012')
    end

    it 'calculates the price_period_end' do
      expect(compositor.context[:price_period_end]).to eq('June 30, 2013')
    end

    it 'calculates the price_verification_date_1' do
      travel_to Date.new(2012) do
        expect(compositor.context[:price_verification_date_1]).to eq('November 30, 2011')
      end
    end

    it 'calculates the price_verification_date_2' do
      travel_to Date.new(2012) do
        expect(compositor.context[:price_verification_date_2]).to eq('July 31, 2011')
      end
    end

    it 'calculates the price_verification_invoice_date_1' do
      travel_to Date.new(2012) do
        expect(compositor.context[:price_verification_invoice_date_1]).to eq('November 2011')
      end
    end

    it 'calculates the price_verification_invoice_date_2' do
      travel_to Date.new(2012) do
        expect(compositor.context[:price_verification_invoice_date_2]).to eq('July 2011')
      end
    end

    it 'calculates the local_percentage' do
      expect(compositor.context[:local_percentage]).to eq('25%')
    end

    it 'calculates the delivery_locations_count' do
      expect(compositor.context[:delivery_locations_count]).to eq(2)
    end

    it 'calculates the delivery_days' do
      expect(compositor.context[:delivery_days]).to eq('Monday, Tuesday, Wednesday')
    end

    it 'calculates the total_deliveries_count' do
      expect(compositor.context[:total_deliveries_count]).to eq(5)
    end

    it 'calculates the allow_piggyback' do
      expect(compositor.context[:allow_piggyback]).to be(true)
    end

    it 'calculates the price_verified' do
      expect(compositor.context[:price_verified]).to be(true)
    end

    it 'includes serialized_deliveries' do
      expect(compositor.context[:deliveries][0]).to include(
        name: 'Delivery location',
        deliveries_per_week: 2,
        delivery_days: 'Monday, Tuesday',
        delivery_window: '10:00 am - 11:00 am',
        address: a_string_including('123 Main')
      )
    end

    it 'includes serialized_scores' do
      expect(compositor.context[:scores]).to eq(
        [
          {name: 'Cat1', point_awarded_basis: 'point awarded basis', point_split_descriptions: 'point split description', value: 60},
          {name: 'Cat2', point_awarded_basis: 'point awarded basis', point_split_descriptions: 'point split description', value: 40}
        ]
      )
    end

    it 'includes vendor_questions' do
      expect(compositor.context[:vendor_questions]).to eq(['Cat1 vendor question', 'Cat2 vendor question'])
    end
  end
end
