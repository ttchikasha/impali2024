require "rails_helper"

RSpec.describe "Admin Login" do
  it "with correct credentials" do
    visit "/"
    click_link "Login"
    expect(page).to have_content "Login"
    email = "john@example.com"
    password = "1234pass"
    u = create :user, :admin, password: password
    fill_in "Login ID", with: u.login_id
    fill_in "Password", with: password
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
    click_link "Dashboard"

    click_link "Notices"
    click_on "New Notice"

    fill_in "Title", with: "Some Notice"
    fill_in "Content", with: "This is very serious"
    # fil
  end
end
