require 'rails_helper'

RSpec.describe Buyers::RfpNavComponent, type: :component do
  let(:rfp) { create(:rfp) }
  let(:component) { described_class.new(current_path: current_path, current_rfp: rfp) }

  describe '#progress_percent' do
    context 'with edit rfp' do
      let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_rfp_path(rfp) }

      it 'returns current' do
        render_inline(component)
        expect(page.find('.document-nav__progress-line')[:style]).to eq('width: 12.5%')
      end
    end

    context 'with scores' do
      let(:current_path) { Rails.application.routes.url_helpers.buyers_rfp_scores_path(rfp) }

      it 'returns current' do
        render_inline(component)
        expect(page.find('.document-nav__progress-line')[:style]).to eq('width: 37.5%')
      end
    end

    context 'with item list' do
      let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_rfp_item_list_path(rfp) }

      it 'returns current' do
        render_inline(component)
        expect(page.find('.document-nav__progress-line')[:style]).to eq('width: 87.5%')
      end
    end
  end

  describe 'classes' do
    context 'with the current page' do
      let(:rfp) { create(:rfp) }
      let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_rfp_path(rfp) }

      it 'returns current' do
        render_inline(component)
        expect(component.classes(Rails.application.routes.url_helpers.edit_buyers_rfp_path(rfp))).to eq('current')
      end
    end
  end

  describe 'current_page?' do
    context 'with district information paths' do
      context 'when editing an rfp' do
        let(:current_path) { Rails.application.routes.url_helpers.edit_buyers_rfp_path(rfp) }

        it 'returns true with edit' do
          render_inline(component)
          expect(component.current_page?(Rails.application.routes.url_helpers.edit_buyers_rfp_path(rfp))).to eq(true)
        end

        it 'returns false with other paths' do
          render_inline(component)
          expect(component.current_page?(Rails.application.routes.url_helpers.buyers_rfp_scores_path(rfp))).to eq(false)
        end
      end
    end
  end
end
