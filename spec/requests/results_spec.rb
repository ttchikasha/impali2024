require 'rails_helper'

RSpec.describe "Results", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/results/show"
      expect(response).to have_http_status(:success)
    end
  end

end
