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

RSpec.describe "/contact_messages", type: :request do
  
  # ContactMessage. As you add validations to ContactMessage, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ContactMessage.create! valid_attributes
      get contact_messages_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      contact_message = ContactMessage.create! valid_attributes
      get contact_message_url(contact_message)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_contact_message_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      contact_message = ContactMessage.create! valid_attributes
      get edit_contact_message_url(contact_message)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ContactMessage" do
        expect {
          post contact_messages_url, params: { contact_message: valid_attributes }
        }.to change(ContactMessage, :count).by(1)
      end

      it "redirects to the created contact_message" do
        post contact_messages_url, params: { contact_message: valid_attributes }
        expect(response).to redirect_to(contact_message_url(ContactMessage.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ContactMessage" do
        expect {
          post contact_messages_url, params: { contact_message: invalid_attributes }
        }.to change(ContactMessage, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post contact_messages_url, params: { contact_message: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested contact_message" do
        contact_message = ContactMessage.create! valid_attributes
        patch contact_message_url(contact_message), params: { contact_message: new_attributes }
        contact_message.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the contact_message" do
        contact_message = ContactMessage.create! valid_attributes
        patch contact_message_url(contact_message), params: { contact_message: new_attributes }
        contact_message.reload
        expect(response).to redirect_to(contact_message_url(contact_message))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        contact_message = ContactMessage.create! valid_attributes
        patch contact_message_url(contact_message), params: { contact_message: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested contact_message" do
      contact_message = ContactMessage.create! valid_attributes
      expect {
        delete contact_message_url(contact_message)
      }.to change(ContactMessage, :count).by(-1)
    end

    it "redirects to the contact_messages list" do
      contact_message = ContactMessage.create! valid_attributes
      delete contact_message_url(contact_message)
      expect(response).to redirect_to(contact_messages_url)
    end
  end
end
