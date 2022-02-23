require 'rails_helper'

RSpec.describe "classrooms/new", type: :view do
  before(:each) do
    assign(:classroom, Classroom.new(
      teacher_id: "",
      grade: 1,
      room: "MyString"
    ))
  end

  it "renders new classroom form" do
    render

    assert_select "form[action=?][method=?]", classrooms_path, "post" do

      assert_select "input[name=?]", "classroom[teacher_id]"

      assert_select "input[name=?]", "classroom[grade]"

      assert_select "input[name=?]", "classroom[room]"
    end
  end
end
