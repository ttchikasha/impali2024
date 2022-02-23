require 'rails_helper'

RSpec.describe "contact_messages/show", type: :view do
  before(:each) do
    @contact_message = assign(:contact_message, ContactMessage.create!(
      name: "Name",
      email: "Email",
      subject: "Subject",
      message: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/MyText/)
  end
end
