require "rails_helper"

RSpec.describe Buyers::NavigationComponent, type: :component do
  before { render_inline(component) }

  let(:buyer) { create(:buyer) }
  let(:component) { described_class.new(current_path: Rails.application.routes.url_helpers.buyers_documents_path, user: buyer) }

  it { expect(page.find('.buyers__nav-link--active')).to have_content(/my documents/i) }
  it { expect(page).to have_content(/district profile/i) }
end
