require 'rails_helper'

RSpec.describe "student_attendances/show", type: :view do
  before(:each) do
    @student_attendance = assign(:student_attendance, StudentAttendance.create!(
      present: false,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
