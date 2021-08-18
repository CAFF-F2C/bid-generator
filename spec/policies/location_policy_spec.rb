require 'rails_helper'

RSpec.describe LocationPolicy do
  subject { described_class.new(buyer, location) }

  context 'when there is no buyer' do
    let(:buyer) { nil }
    let(:location) { create(:location) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'when there is a buyer that owns the location' do
    let(:buyer) { create(:buyer) }
    let(:location) { create(:location, buyer: buyer) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'when there is a buyer that does not own the location' do
    let(:buyer) { create(:buyer) }
    let(:location) { create(:location) }

    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
