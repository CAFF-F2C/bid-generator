require 'rails_helper'

RSpec.describe Buyers::DistrictProfiles::Section::Component, type: :component do
  subject(:component) { described_class.new(name: 'RFP Contact', description: 'Who picks up the phone?', path: '/') }

  it 'renders the descriptive text' do
    render_inline(component)
    expect(page)
      .to have_content('RFP Contact')
      .and have_content('Who picks up the phone?')
      .and have_link('Update')
  end

  context 'when there is a field' do
    let(:district_profile) { FactoryBot.create(:district_profile, contact_full_name: 'Food Service Supervisor') }

    it 'renders the field' do
      render_inline(component) do |c|
        c.field(district_profile: district_profile, section: :rfp_contact, name: :contact_full_name)
      end
      expect(page)
        .to have_content('Full name')
        .and have_content('Food Service Supervisor')
    end
  end

  context 'when there is a field with errors' do
    let(:district_profile) { FactoryBot.create(:district_profile, contact_full_name: nil) }

    it 'renders the field' do
      render_inline(component) do |c|
        c.field(district_profile: district_profile, section: :rfp_contact, name: :contact_full_name)
      end
      expect(page)
        .to have_content('Full name')
        .and have_content('Incomplete')
    end
  end
end
