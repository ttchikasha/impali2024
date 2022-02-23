require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(
        term: 2,
        year: 3,
        deposit_slip: nil,
        amount: "9.99",
        user: nil
      ),
      Payment.create!(
        term: 2,
        year: 3,
        deposit_slip: nil,
        amount: "9.99",
        user: nil
      )
    ])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
