require "rails_helper"

RSpec.describe OnlineApplicationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/online_applications").to route_to("online_applications#index")
    end

    it "routes to #new" do
      expect(get: "/online_applications/new").to route_to("online_applications#new")
    end

    it "routes to #show" do
      expect(get: "/online_applications/1").to route_to("online_applications#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/online_applications/1/edit").to route_to("online_applications#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/online_applications").to route_to("online_applications#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/online_applications/1").to route_to("online_applications#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/online_applications/1").to route_to("online_applications#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/online_applications/1").to route_to("online_applications#destroy", id: "1")
    end
  end
end
