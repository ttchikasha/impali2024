require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    assign(:notification, Notification.new(
      notifiable: nil,
      title: "MyString",
      content: "MyText"
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do

      assert_select "input[name=?]", "notification[notifiable_id]"

      assert_select "input[name=?]", "notification[title]"

      assert_select "textarea[name=?]", "notification[content]"
    end
  end
end
