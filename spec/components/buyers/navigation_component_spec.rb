require 'rails_helper'

RSpec.describe Buyers::NavigationComponent, type: :component do
  before { render_inline(component) }

  let(:buyer) { create(:buyer) }
  let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.buyers_documents_path, user: buyer) }

  it { expect(page.find('.buyers__nav-link--active')).to have_content(/my documents/i) }
  it { expect(page).to have_content(/district profile/i) }
  it { expect(page).to have_content(/sign out/i) }

  describe '#external_resources_link' do
    before { allow(Rails.application.config).to receive(:external_resources_link).and_return('http://example.com') }

    it 'returns the config variable' do
      expect(component.external_resources_link).to eq('http://example.com')
    end
  end
end
