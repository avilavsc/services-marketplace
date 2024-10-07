require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let(:provider_user) { create(:user, role: "provider") }

  before do
    sign_in provider_user
  end

  describe "GET /dashboard" do
    it "returns http success" do
      get "/dashboard"
      expect(response).to have_http_status(:success)
    end
  end
end
