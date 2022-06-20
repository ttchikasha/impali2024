require "rails_helper"

RSpec.describe "classroom_subjects/new", type: :view do
  before(:each) do
    assign(:classroom_subject, build(:classroom_subject))
  end

  it "renders new classroom_subject form" do
    render

    assert_select "form[action=?][method=?]", classroom_subjects_path, "post" do
      assert_select "input[name=?]", "classroom_subject[teacher_id]"
    end
  end
end
