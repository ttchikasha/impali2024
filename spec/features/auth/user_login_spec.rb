require "rails_helper"

RSpec.feature "User Login In" do
  scenario "login page" do
    visit "/"
    click_link "Login"
    expect(page).to have_content "Login"
  end
end
