require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      notifiable: nil,
      title: "MyString",
      content: "MyText"
    ))
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "input[name=?]", "notification[notifiable_id]"

      assert_select "input[name=?]", "notification[title]"

      assert_select "textarea[name=?]", "notification[content]"
    end
  end
end
