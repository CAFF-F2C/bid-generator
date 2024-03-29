require 'rails_helper'

RSpec.describe FlashComponent, type: :component do
  before { render_inline(component) }

  context 'when there is an alert' do
    let(:component) { described_class.new(flash: {alert: 'alert message'}) }

    it { expect(page).to have_content('alert message') }
  end

  context 'when there is a notice' do
    let(:component) { described_class.new(flash: {notice: 'notice message'}) }

    it { expect(page).to have_content('notice message') }
  end

  context 'when there is a non-standard flash message' do
    let(:component) { described_class.new(flash: {bad_notice: 'non valid message'}) }

    it { expect(page).to have_content('non valid message') }
  end
end
