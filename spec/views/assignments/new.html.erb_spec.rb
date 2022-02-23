require 'rails_helper'

RSpec.describe "assignments/new", type: :view do
  before(:each) do
    assign(:assignment, Assignment.new(
      user: nil,
      classroom_subject: nil
    ))
  end

  it "renders new assignment form" do
    render

    assert_select "form[action=?][method=?]", assignments_path, "post" do

      assert_select "input[name=?]", "assignment[user_id]"

      assert_select "input[name=?]", "assignment[classroom_subject_id]"
    end
  end
end
