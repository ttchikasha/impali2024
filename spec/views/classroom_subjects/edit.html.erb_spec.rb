require 'rails_helper'

RSpec.describe "classroom_subjects/edit", type: :view do
  before(:each) do
    @classroom_subject = assign(:classroom_subject, ClassroomSubject.create!(
      subject: nil,
      classroom: nil,
      teacher_id: ""
    ))
  end

  it "renders the edit classroom_subject form" do
    render

    assert_select "form[action=?][method=?]", classroom_subject_path(@classroom_subject), "post" do

      assert_select "input[name=?]", "classroom_subject[subject_id]"

      assert_select "input[name=?]", "classroom_subject[classroom_id]"

      assert_select "input[name=?]", "classroom_subject[teacher_id]"
    end
  end
end
