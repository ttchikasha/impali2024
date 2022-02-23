require 'rails_helper'

RSpec.describe "school_payments/show", type: :view do
  before(:each) do
    @school_payment = assign(:school_payment, SchoolPayment.create!(
      levy: "9.99",
      tution: "9.99",
      year: 2,
      term: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
