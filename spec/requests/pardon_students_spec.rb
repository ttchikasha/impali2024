require 'rails_helper'

RSpec.describe "PardonStudents", type: :request do
  describe "GET /pardon" do
    it "returns http success" do
      get "/pardon_students/pardon"
      expect(response).to have_http_status(:success)
    end
  end

end
