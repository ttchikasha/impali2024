require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/parents", type: :request do
  
  # Parent. As you add validations to Parent, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Parent.create! valid_attributes
      get parents_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      parent = Parent.create! valid_attributes
      get parent_url(parent)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_parent_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      parent = Parent.create! valid_attributes
      get edit_parent_url(parent)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Parent" do
        expect {
          post parents_url, params: { parent: valid_attributes }
        }.to change(Parent, :count).by(1)
      end

      it "redirects to the created parent" do
        post parents_url, params: { parent: valid_attributes }
        expect(response).to redirect_to(parent_url(Parent.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Parent" do
        expect {
          post parents_url, params: { parent: invalid_attributes }
        }.to change(Parent, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post parents_url, params: { parent: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested parent" do
        parent = Parent.create! valid_attributes
        patch parent_url(parent), params: { parent: new_attributes }
        parent.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the parent" do
        parent = Parent.create! valid_attributes
        patch parent_url(parent), params: { parent: new_attributes }
        parent.reload
        expect(response).to redirect_to(parent_url(parent))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        parent = Parent.create! valid_attributes
        patch parent_url(parent), params: { parent: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested parent" do
      parent = Parent.create! valid_attributes
      expect {
        delete parent_url(parent)
      }.to change(Parent, :count).by(-1)
    end

    it "redirects to the parents list" do
      parent = Parent.create! valid_attributes
      delete parent_url(parent)
      expect(response).to redirect_to(parents_url)
    end
  end
end
