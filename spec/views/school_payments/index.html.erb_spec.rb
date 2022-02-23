require 'rails_helper'

RSpec.describe "school_payments/index", type: :view do
  before(:each) do
    assign(:school_payments, [
      SchoolPayment.create!(
        levy: "9.99",
        tution: "9.99",
        year: 2,
        term: 3
      ),
      SchoolPayment.create!(
        levy: "9.99",
        tution: "9.99",
        year: 2,
        term: 3
      )
    ])
  end

  it "renders a list of school_payments" do
    render
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
