require 'rails_helper'

RSpec.describe "payments/edit", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      term: 1,
      year: 1,
      deposit_slip: nil,
      amount: "9.99",
      user: nil
    ))
  end

  it "renders the edit payment form" do
    render

    assert_select "form[action=?][method=?]", payment_path(@payment), "post" do

      assert_select "input[name=?]", "payment[term]"

      assert_select "input[name=?]", "payment[year]"

      assert_select "input[name=?]", "payment[deposit_slip]"

      assert_select "input[name=?]", "payment[amount]"

      assert_select "input[name=?]", "payment[user_id]"
    end
  end
end
