require 'rails_helper'

RSpec.describe "online_applications/show", type: :view do
  before(:each) do
    @online_application = assign(:online_application, OnlineApplication.create!(
      first_name: "First Name",
      last_name: "Last Name",
      phone: "Phone",
      email: "Email",
      grade: 2,
      gender: "Gender",
      address: "Address",
      city: "City"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
  end
end
