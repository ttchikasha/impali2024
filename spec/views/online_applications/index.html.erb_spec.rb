require 'rails_helper'

RSpec.describe "online_applications/index", type: :view do
  before(:each) do
    assign(:online_applications, [
      OnlineApplication.create!(
        first_name: "First Name",
        last_name: "Last Name",
        phone: "Phone",
        email: "Email",
        grade: 2,
        gender: "Gender",
        address: "Address",
        city: "City"
      ),
      OnlineApplication.create!(
        first_name: "First Name",
        last_name: "Last Name",
        phone: "Phone",
        email: "Email",
        grade: 2,
        gender: "Gender",
        address: "Address",
        city: "City"
      )
    ])
  end

  it "renders a list of online_applications" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Gender".to_s, count: 2
    assert_select "tr>td", text: "Address".to_s, count: 2
    assert_select "tr>td", text: "City".to_s, count: 2
  end
end
