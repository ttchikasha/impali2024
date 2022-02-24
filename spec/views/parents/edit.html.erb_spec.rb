require 'rails_helper'

RSpec.describe "parents/edit", type: :view do
  before(:each) do
    @parent = assign(:parent, Parent.create!(
      user: nil,
      name: "MyString",
      title: "MyString",
      phone: "MyString",
      email: "MyString",
      occupation: "MyString",
      id_no: "MyString"
    ))
  end

  it "renders the edit parent form" do
    render

    assert_select "form[action=?][method=?]", parent_path(@parent), "post" do

      assert_select "input[name=?]", "parent[user_id]"

      assert_select "input[name=?]", "parent[name]"

      assert_select "input[name=?]", "parent[title]"

      assert_select "input[name=?]", "parent[phone]"

      assert_select "input[name=?]", "parent[email]"

      assert_select "input[name=?]", "parent[occupation]"

      assert_select "input[name=?]", "parent[id_no]"
    end
  end
end
