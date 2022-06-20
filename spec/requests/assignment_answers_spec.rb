require 'rails_helper'

RSpec.describe "AssignmentAnswers", type: :request do
  describe "GET /index" do
    ass = create :assignment
    post :assignment_answers, params: {{}}
    pending "add some examples (or delete) #{__FILE__}"
  end
end
