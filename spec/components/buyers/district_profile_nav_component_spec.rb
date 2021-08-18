require 'rails_helper'

RSpec.describe Buyers::DistrictProfileNavComponent, type: :component do
  before { render_inline(component) }

  let(:component) { described_class.new(current_path: current_path) }

  describe '#progress_percent' do
    context 'with new profile' do
      let(:current_path) { Rails.application.routes.url_helpers.new_buyers_district_profile_path }

      it 'returns current' do
        expect(component.progress_percent).to eq('12.5%')
      end
    end

    context 'with edit profile' do
      let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_district_profile_path }

      it 'returns current' do
        expect(component.progress_percent).to eq('12.5%')
      end
    end

    context 'with contact' do
      let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_district_profile_contact_path }

      it 'returns current' do
        expect(component.progress_percent).to eq('37.5%')
      end
    end

    context 'with locations' do
      let(:current_path) { Rails.application.routes.url_helpers.buyers_district_profile_locations_path }

      it 'returns current' do
        expect(component.progress_percent).to eq('87.5%')
      end
    end
  end

  describe 'classes' do
    context 'with the current page' do
      let(:current_path) { Rails.application.routes.url_helpers.new_buyers_district_profile_path }

      it 'returns current' do
        expect(component.classes(Rails.application.routes.url_helpers.new_buyers_district_profile_path)).to eq('current')
      end
    end
  end

  describe 'current_page?' do
    context 'with district information paths' do
      context 'with new district profile' do
        let(:current_path) { Rails.application.routes.url_helpers.new_buyers_district_profile_path }

        it 'returns true with new' do
          expect(component.current_page?(Rails.application.routes.url_helpers.new_buyers_district_profile_path)).to eq(true)
        end

        it 'returns true with edit' do
          expect(component.current_page?(Rails.application.routes.url_helpers.edit_buyers_district_profile_path)).to eq(true)
        end

        it 'returns false with other paths' do
          expect(component.current_page?(Rails.application.routes.url_helpers.edit_buyers_district_profile_contact_path)).to eq(false)
        end
      end

      context 'when editing a district profile' do
        let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_district_profile_path }

        it 'returns true with new' do
          expect(component.current_page?(Rails.application.routes.url_helpers.new_buyers_district_profile_path)).to eq(true)
        end

        it 'returns true with edit' do
          expect(component.current_page?(Rails.application.routes.url_helpers.edit_buyers_district_profile_path)).to eq(true)
        end

        it 'returns false with other paths' do
          expect(component.current_page?(Rails.application.routes.url_helpers.edit_buyers_district_profile_contact_path)).to eq(false)
        end
      end
    end
  end
end
