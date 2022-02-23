require "rails_helper"

RSpec.describe SchoolPaymentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/school_payments").to route_to("school_payments#index")
    end

    it "routes to #new" do
      expect(get: "/school_payments/new").to route_to("school_payments#new")
    end

    it "routes to #show" do
      expect(get: "/school_payments/1").to route_to("school_payments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/school_payments/1/edit").to route_to("school_payments#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/school_payments").to route_to("school_payments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/school_payments/1").to route_to("school_payments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/school_payments/1").to route_to("school_payments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/school_payments/1").to route_to("school_payments#destroy", id: "1")
    end
  end
end
