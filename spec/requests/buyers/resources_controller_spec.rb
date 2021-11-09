require 'rails_helper'

RSpec.describe Buyers::ResourcesController, type: :request do
  describe 'GET #show' do
    def make_request
      get buyers_resources_path
    end

    before { Rails.application.config.external_resources_link = 'http://example.com/resources' }

    it 'redirects to the resource folder' do
      make_request
      expect(response).to redirect_to('http://example.com/resources')
    end
  end
end
