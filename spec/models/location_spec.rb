require 'rails_helper'

RSpec.describe Location, type: :model do
  subject(:location) { FactoryBot.create(:location, buyer: buyer) }

  let(:buyer) { create(:buyer) }

  it { is_expected.to belong_to(:buyer).inverse_of(:locations) }
  it { is_expected.to have_many(:deliveries).inverse_of(:location) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:street_address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:zip_code) }

  describe '#name_with_address' do
    let(:location) { create(:location, name: 'My Location', street_address: '123 Main', city: 'ATown', state: 'CA', zip_code: '12345') }

    it 'returns the name and full address' do
      expect(location.name_with_address).to eq('My Location (123 Main, ATown, CA 12345)')
    end
  end

  describe '#full_address' do
    let(:location) { create(:location, street_address: '123 Main', city: 'ATown', state: 'CA', zip_code: '12345') }

    it 'returns the full address' do
      expect(location.full_address).to eq('123 Main, ATown, CA 12345')
    end
  end
end
