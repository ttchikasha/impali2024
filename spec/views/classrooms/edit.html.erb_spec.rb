require 'rails_helper'

RSpec.describe "classrooms/edit", type: :view do
  before(:each) do
    @classroom = assign(:classroom, Classroom.create!(
      teacher_id: "",
      grade: 1,
      room: "MyString"
    ))
  end

  it "renders the edit classroom form" do
    render

    assert_select "form[action=?][method=?]", classroom_path(@classroom), "post" do

      assert_select "input[name=?]", "classroom[teacher_id]"

      assert_select "input[name=?]", "classroom[grade]"

      assert_select "input[name=?]", "classroom[room]"
    end
  end
end
