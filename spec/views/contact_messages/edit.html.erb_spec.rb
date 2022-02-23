require 'rails_helper'

RSpec.describe "contact_messages/edit", type: :view do
  before(:each) do
    @contact_message = assign(:contact_message, ContactMessage.create!(
      name: "MyString",
      email: "MyString",
      subject: "MyString",
      message: "MyText"
    ))
  end

  it "renders the edit contact_message form" do
    render

    assert_select "form[action=?][method=?]", contact_message_path(@contact_message), "post" do

      assert_select "input[name=?]", "contact_message[name]"

      assert_select "input[name=?]", "contact_message[email]"

      assert_select "input[name=?]", "contact_message[subject]"

      assert_select "textarea[name=?]", "contact_message[message]"
    end
  end
end
