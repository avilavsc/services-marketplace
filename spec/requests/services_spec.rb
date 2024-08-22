require 'rails_helper'

RSpec.describe "Services", type: :request do
  describe "GET /index" do
    it "returns a success response" do
      get services_path
      expect(response).to be_successful
    end

    it "passes a query parameter and renders it" do
      get services_path, params: { search: "term" }
      expect(response).to be_successful
      expect(response.body).to include("term")
    end
  end
end
