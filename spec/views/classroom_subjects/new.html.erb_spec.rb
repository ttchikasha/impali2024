require 'rails_helper'

RSpec.describe "classroom_subjects/new", type: :view do
  before(:each) do
    assign(:classroom_subject, ClassroomSubject.new(
      subject: nil,
      classroom: nil,
      teacher_id: ""
    ))
  end

  it "renders new classroom_subject form" do
    render

    assert_select "form[action=?][method=?]", classroom_subjects_path, "post" do

      assert_select "input[name=?]", "classroom_subject[subject_id]"

      assert_select "input[name=?]", "classroom_subject[classroom_id]"

      assert_select "input[name=?]", "classroom_subject[teacher_id]"
    end
  end
end
