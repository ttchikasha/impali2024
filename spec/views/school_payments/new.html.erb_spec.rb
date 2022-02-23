require 'rails_helper'

RSpec.describe "school_payments/new", type: :view do
  before(:each) do
    assign(:school_payment, SchoolPayment.new(
      levy: "9.99",
      tution: "9.99",
      year: 1,
      term: 1
    ))
  end

  it "renders new school_payment form" do
    render

    assert_select "form[action=?][method=?]", school_payments_path, "post" do

      assert_select "input[name=?]", "school_payment[levy]"

      assert_select "input[name=?]", "school_payment[tution]"

      assert_select "input[name=?]", "school_payment[year]"

      assert_select "input[name=?]", "school_payment[term]"
    end
  end
end
