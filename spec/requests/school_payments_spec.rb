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

RSpec.describe "/school_payments", type: :request do
  
  # SchoolPayment. As you add validations to SchoolPayment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      SchoolPayment.create! valid_attributes
      get school_payments_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      school_payment = SchoolPayment.create! valid_attributes
      get school_payment_url(school_payment)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_school_payment_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      school_payment = SchoolPayment.create! valid_attributes
      get edit_school_payment_url(school_payment)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new SchoolPayment" do
        expect {
          post school_payments_url, params: { school_payment: valid_attributes }
        }.to change(SchoolPayment, :count).by(1)
      end

      it "redirects to the created school_payment" do
        post school_payments_url, params: { school_payment: valid_attributes }
        expect(response).to redirect_to(school_payment_url(SchoolPayment.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new SchoolPayment" do
        expect {
          post school_payments_url, params: { school_payment: invalid_attributes }
        }.to change(SchoolPayment, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post school_payments_url, params: { school_payment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested school_payment" do
        school_payment = SchoolPayment.create! valid_attributes
        patch school_payment_url(school_payment), params: { school_payment: new_attributes }
        school_payment.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the school_payment" do
        school_payment = SchoolPayment.create! valid_attributes
        patch school_payment_url(school_payment), params: { school_payment: new_attributes }
        school_payment.reload
        expect(response).to redirect_to(school_payment_url(school_payment))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        school_payment = SchoolPayment.create! valid_attributes
        patch school_payment_url(school_payment), params: { school_payment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested school_payment" do
      school_payment = SchoolPayment.create! valid_attributes
      expect {
        delete school_payment_url(school_payment)
      }.to change(SchoolPayment, :count).by(-1)
    end

    it "redirects to the school_payments list" do
      school_payment = SchoolPayment.create! valid_attributes
      delete school_payment_url(school_payment)
      expect(response).to redirect_to(school_payments_url)
    end
  end
end
