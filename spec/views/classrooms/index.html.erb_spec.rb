require 'rails_helper'

RSpec.describe "classrooms/index", type: :view do
  before(:each) do
    assign(:classrooms, [
      Classroom.create!(
        teacher_id: "",
        grade: 2,
        room: "Room"
      ),
      Classroom.create!(
        teacher_id: "",
        grade: 2,
        room: "Room"
      )
    ])
  end

  it "renders a list of classrooms" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Room".to_s, count: 2
  end
end
