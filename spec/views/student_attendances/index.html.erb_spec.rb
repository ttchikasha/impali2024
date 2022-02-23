require 'rails_helper'

RSpec.describe "student_attendances/index", type: :view do
  before(:each) do
    assign(:student_attendances, [
      StudentAttendance.create!(
        present: false,
        user: nil
      ),
      StudentAttendance.create!(
        present: false,
        user: nil
      )
    ])
  end

  it "renders a list of student_attendances" do
    render
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
