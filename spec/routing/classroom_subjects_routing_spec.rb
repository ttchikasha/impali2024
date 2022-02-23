require "rails_helper"

RSpec.describe ClassroomSubjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/classroom_subjects").to route_to("classroom_subjects#index")
    end

    it "routes to #new" do
      expect(get: "/classroom_subjects/new").to route_to("classroom_subjects#new")
    end

    it "routes to #show" do
      expect(get: "/classroom_subjects/1").to route_to("classroom_subjects#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/classroom_subjects/1/edit").to route_to("classroom_subjects#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/classroom_subjects").to route_to("classroom_subjects#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/classroom_subjects/1").to route_to("classroom_subjects#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/classroom_subjects/1").to route_to("classroom_subjects#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/classroom_subjects/1").to route_to("classroom_subjects#destroy", id: "1")
    end
  end
end
