require 'rails_helper'

RSpec.describe "Buyers::DistrictProfiles", type: :request do
  describe "GET /index" do
    def make_request
      get buyers_district_profile_path
    end
  end

end
