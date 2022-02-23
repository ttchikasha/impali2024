require 'rails_helper'

RSpec.describe "classroom_subjects/index", type: :view do
  before(:each) do
    assign(:classroom_subjects, [
      ClassroomSubject.create!(
        subject: nil,
        classroom: nil,
        teacher_id: ""
      ),
      ClassroomSubject.create!(
        subject: nil,
        classroom: nil,
        teacher_id: ""
      )
    ])
  end

  it "renders a list of classroom_subjects" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
