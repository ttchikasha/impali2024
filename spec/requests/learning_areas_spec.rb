require 'rails_helper'

RSpec.describe "LearningAreas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/learning_areas/index"
      expect(response).to have_http_status(:success)
    end
  end

end
