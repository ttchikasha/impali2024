require 'rails_helper'

RSpec.describe "online_applications/new", type: :view do
  before(:each) do
    assign(:online_application, OnlineApplication.new(
      first_name: "MyString",
      last_name: "MyString",
      phone: "MyString",
      email: "MyString",
      grade: 1,
      gender: "MyString",
      address: "MyString",
      city: "MyString"
    ))
  end

  it "renders new online_application form" do
    render

    assert_select "form[action=?][method=?]", online_applications_path, "post" do

      assert_select "input[name=?]", "online_application[first_name]"

      assert_select "input[name=?]", "online_application[last_name]"

      assert_select "input[name=?]", "online_application[phone]"

      assert_select "input[name=?]", "online_application[email]"

      assert_select "input[name=?]", "online_application[grade]"

      assert_select "input[name=?]", "online_application[gender]"

      assert_select "input[name=?]", "online_application[address]"

      assert_select "input[name=?]", "online_application[city]"
    end
  end
end
