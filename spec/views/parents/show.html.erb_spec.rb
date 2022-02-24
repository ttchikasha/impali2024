require 'rails_helper'

RSpec.describe "parents/show", type: :view do
  before(:each) do
    @parent = assign(:parent, Parent.create!(
      user: nil,
      name: "Name",
      title: "Title",
      phone: "Phone",
      email: "Email",
      occupation: "Occupation",
      id_no: "Id No"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Occupation/)
    expect(rendered).to match(/Id No/)
  end
end
