require "rails_helper"

RSpec.feature "User Login In" do
  scenario "with correct credentials" do
    visit "/"
    click_link "Login"
    expect(page).to have_content "Login"
    email = "john@example.com"
    password = "1234pass"
    u = create :user, password: password
    fill_in "Login ID", with: u.login_id
    fill_in "Password", with: password
    click_button "Log in"
    expect(page).to have_content "Signed in successfully"
  end

  scenario "with in-correct credentials" do
    visit "/"
    click_link "Login"
    expect(page).to have_content "Login"
    u = create :user
    fill_in "Login ID", with: u.login_id
    fill_in "Password", with: SecureRandom.hex(3)
    click_button "Log in"
    expect(page).to have_content "Invalid Login or password"
  end
end
