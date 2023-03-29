require "rails_helper"

RSpec.describe ReportCommentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/report_comments").to route_to("report_comments#index")
    end

    it "routes to #new" do
      expect(get: "/report_comments/new").to route_to("report_comments#new")
    end

    it "routes to #show" do
      expect(get: "/report_comments/1").to route_to("report_comments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/report_comments/1/edit").to route_to("report_comments#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/report_comments").to route_to("report_comments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/report_comments/1").to route_to("report_comments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/report_comments/1").to route_to("report_comments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/report_comments/1").to route_to("report_comments#destroy", id: "1")
    end
  end
end
