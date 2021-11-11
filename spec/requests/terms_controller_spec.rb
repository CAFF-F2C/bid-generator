require 'rails_helper'

RSpec.describe TermsController, type: :request do
  let(:page) { Capybara.string(response.body) }

  describe 'GET #show' do
    def make_request
      get terms_path
    end

    it 'renders terms and conditions' do
      make_request
      expect(page).to have_content('Terms and Conditions')
    end
  end
end
