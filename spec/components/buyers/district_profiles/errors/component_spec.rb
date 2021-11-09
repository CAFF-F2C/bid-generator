require 'rails_helper'

RSpec.describe Buyers::DistrictProfiles::Errors::Component, type: :component do
  subject(:component) { described_class.new(district_profile: district_profile, sections: []) }

  let(:district_profile) { FactoryBot.create(:district_profile) }

  context 'when there are no sections' do
    it 'does not render' do
      render_inline(component)
      expect(page.text).to be_empty
    end
  end

  context 'when there is a section with missing fields' do
    let(:component) { described_class.new(district_profile: district_profile, sections: [:district_information]) }

    it 'renders the error block' do
      render_inline(component)
      expect(page.text)
        .to include('errors with your district profile')
        .and include('District Information is missing')
        .and include('City')
        .and include('County')
        .and include('Number of enrolled students')
    end
  end
end
