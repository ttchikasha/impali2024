require 'rails_helper'

RSpec.describe "parents/index", type: :view do
  before(:each) do
    assign(:parents, [
      Parent.create!(
        user: nil,
        name: "Name",
        title: "Title",
        phone: "Phone",
        email: "Email",
        occupation: "Occupation",
        id_no: "Id No"
      ),
      Parent.create!(
        user: nil,
        name: "Name",
        title: "Title",
        phone: "Phone",
        email: "Email",
        occupation: "Occupation",
        id_no: "Id No"
      )
    ])
  end

  it "renders a list of parents" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Occupation".to_s, count: 2
    assert_select "tr>td", text: "Id No".to_s, count: 2
  end
end
