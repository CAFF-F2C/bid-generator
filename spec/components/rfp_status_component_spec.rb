require 'rails_helper'

RSpec.describe RfpStatusComponent, type: :component do
  let(:rfp) { create(:rfp) }
  let(:component) { described_class.new(rfp: rfp) }

  it 'shows the status' do
    render_inline(component)
    expect(page).to have_content(/in progress/i)
  end
end
