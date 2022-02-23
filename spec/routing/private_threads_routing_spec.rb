require "rails_helper"

RSpec.describe PrivateThreadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/private_threads").to route_to("private_threads#index")
    end

    it "routes to #new" do
      expect(get: "/private_threads/new").to route_to("private_threads#new")
    end

    it "routes to #show" do
      expect(get: "/private_threads/1").to route_to("private_threads#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/private_threads/1/edit").to route_to("private_threads#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/private_threads").to route_to("private_threads#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/private_threads/1").to route_to("private_threads#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/private_threads/1").to route_to("private_threads#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/private_threads/1").to route_to("private_threads#destroy", id: "1")
    end
  end
end
