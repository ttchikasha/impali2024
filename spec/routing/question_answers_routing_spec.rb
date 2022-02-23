require "rails_helper"

RSpec.describe QuestionAnswersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/question_answers").to route_to("question_answers#index")
    end

    it "routes to #new" do
      expect(get: "/question_answers/new").to route_to("question_answers#new")
    end

    it "routes to #show" do
      expect(get: "/question_answers/1").to route_to("question_answers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/question_answers/1/edit").to route_to("question_answers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/question_answers").to route_to("question_answers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/question_answers/1").to route_to("question_answers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/question_answers/1").to route_to("question_answers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/question_answers/1").to route_to("question_answers#destroy", id: "1")
    end
  end
end
