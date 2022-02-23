require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      term: 1,
      year: 1,
      deposit_slip: nil,
      amount: "9.99",
      user: nil
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input[name=?]", "payment[term]"

      assert_select "input[name=?]", "payment[year]"

      assert_select "input[name=?]", "payment[deposit_slip]"

      assert_select "input[name=?]", "payment[amount]"

      assert_select "input[name=?]", "payment[user_id]"
    end
  end
end
