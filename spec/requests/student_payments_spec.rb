require 'rails_helper'

RSpec.describe "StudentPayments", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/student_payments/new"
      expect(response).to have_http_status(:success)
    end
  end

end
