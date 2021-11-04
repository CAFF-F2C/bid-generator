require 'rails_helper'

RSpec.describe Buyers::NavigationComponent, type: :component do
  before { render_inline(component) }

  let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.buyers_documents_path) }

  it { expect(page).to have_content(/district profile/i) }
  it { expect(page.find('.buyers__nav-link--active')).to have_content(/request for proposal/i) }
  it { expect(page).to have_content(/resources/i) }
  it { expect(page).to have_content(/sign out/i) }

  describe '#external_resources_link' do
    before { allow(Rails.application.config).to receive(:external_resources_link).and_return('http://example.com') }

    it 'returns the config variable' do
      expect(component.external_resources_link).to eq('http://example.com')
    end
  end

  context 'when district profile #show' do
    let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.buyers_district_profile_path) }

    it { expect(page.find('.buyers__nav-link--active')).to have_content(/district profile/i) }
  end

  context 'when district profile #new' do
    let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.new_buyers_district_profile_path) }

    it { expect(page.find('.buyers__nav-link--active')).to have_content(/district profile/i) }
  end

  context 'when district profile #edit' do
    let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.edit_buyers_district_profile_path) }

    it { expect(page.find('.buyers__nav-link--active')).to have_content(/district profile/i) }
  end

  context 'when district profile contact' do
    let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.edit_buyers_district_profile_contact_path) }

    it { expect(page.find('.buyers__nav-link--active')).to have_content(/district profile/i) }
  end

  context 'when district profile produrement' do
    let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.edit_buyers_district_profile_procurement_path) }

    it { expect(page.find('.buyers__nav-link--active')).to have_content(/district profile/i) }
  end

  context 'when district profile locations' do
    let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.buyers_district_profile_locations_path) }

    it { expect(page.find('.buyers__nav-link--active')).to have_content(/district profile/i) }
  end
end
