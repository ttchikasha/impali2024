require 'rails_helper'

RSpec.describe "contact_messages/new", type: :view do
  before(:each) do
    assign(:contact_message, ContactMessage.new(
      name: "MyString",
      email: "MyString",
      subject: "MyString",
      message: "MyText"
    ))
  end

  it "renders new contact_message form" do
    render

    assert_select "form[action=?][method=?]", contact_messages_path, "post" do

      assert_select "input[name=?]", "contact_message[name]"

      assert_select "input[name=?]", "contact_message[email]"

      assert_select "input[name=?]", "contact_message[subject]"

      assert_select "textarea[name=?]", "contact_message[message]"
    end
  end
end
