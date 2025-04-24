require 'rails_helper'

RSpec.describe Buyers::ScorePresets::Component, type: :component do
  let(:rfp) { create(:rfp) }
  let(:preset) { create(:score_preset, procurement_type: rfp.procurement_type) }
  let(:component) { described_class.new(current_rfp: rfp, preset: preset) }
  let(:price) { create(:score_category, name: 'Price') }
  let(:cat4) { create(:score_category, name: 'Cat 4') }
  let(:cat3) { create(:score_category, name: 'Cat 3') }
  let(:cat2) { create(:score_category, name: 'Cat 2') }

  before do
    rfp.procurement_type.procurement_type_score_categories.create(score_category: price, position: 0)
    rfp.procurement_type.procurement_type_score_categories.create(score_category: cat4, position: 4)
    rfp.procurement_type.procurement_type_score_categories.create(score_category: cat3, position: 3)
    rfp.procurement_type.procurement_type_score_categories.create(score_category: cat2, position: 2)

    create(:score_preset_value, score_preset: preset, score_category: price, value: 55)
    create(:score_preset_value, score_preset: preset, score_category: cat3, value: 25)
    create(:score_preset_value, score_preset: preset, score_category: cat4, value: 1)

    create(:score, rfp: rfp, score_category: price, value: 30)
    create(:score, rfp: rfp, score_category: cat3, value: 27)
    create(:score, rfp: rfp, score_category: cat4, value: 1)
  end

  it 'renders the suggested scores' do
    render_inline(component)
    expect(page.find("#score_category_#{price.id}")).to have_content('Price').and have_content('30').and have_content('55').and have_content('25')
    expect(page.find("#score_category_#{cat3.id}")).to have_content('Cat 3').and have_content('27').and have_content('25').and have_content('2')
    expect(page.find("#score_category_#{cat4.id}")).to have_content('Cat 4').and have_content('1')
    expect(page.find("#score_category_#{cat2.id}")).to have_content('Cat 2').and have_content('0')
  end
end
