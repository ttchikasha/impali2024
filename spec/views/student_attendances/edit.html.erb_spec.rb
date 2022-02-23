require 'rails_helper'

RSpec.describe "student_attendances/edit", type: :view do
  before(:each) do
    @student_attendance = assign(:student_attendance, StudentAttendance.create!(
      present: false,
      user: nil
    ))
  end

  it "renders the edit student_attendance form" do
    render

    assert_select "form[action=?][method=?]", student_attendance_path(@student_attendance), "post" do

      assert_select "input[name=?]", "student_attendance[present]"

      assert_select "input[name=?]", "student_attendance[user_id]"
    end
  end
end
