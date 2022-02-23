require 'rails_helper'

RSpec.describe "student_attendances/new", type: :view do
  before(:each) do
    assign(:student_attendance, StudentAttendance.new(
      present: false,
      user: nil
    ))
  end

  it "renders new student_attendance form" do
    render

    assert_select "form[action=?][method=?]", student_attendances_path, "post" do

      assert_select "input[name=?]", "student_attendance[present]"

      assert_select "input[name=?]", "student_attendance[user_id]"
    end
  end
end
