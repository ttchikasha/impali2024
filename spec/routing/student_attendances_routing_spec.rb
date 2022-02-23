require "rails_helper"

RSpec.describe StudentAttendancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/student_attendances").to route_to("student_attendances#index")
    end

    it "routes to #new" do
      expect(get: "/student_attendances/new").to route_to("student_attendances#new")
    end

    it "routes to #show" do
      expect(get: "/student_attendances/1").to route_to("student_attendances#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/student_attendances/1/edit").to route_to("student_attendances#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/student_attendances").to route_to("student_attendances#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/student_attendances/1").to route_to("student_attendances#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/student_attendances/1").to route_to("student_attendances#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/student_attendances/1").to route_to("student_attendances#destroy", id: "1")
    end
  end
end
