require 'rails_helper'

RSpec.describe "reports/edit", type: :view do
  before(:each) do
    @report = assign(:report, Report.create!(
      classroom_subject: nil,
      user: nil,
      actual_mark: 1,
      total_marks: 1,
      report_type: 1
    ))
  end

  it "renders the edit report form" do
    render

    assert_select "form[action=?][method=?]", report_path(@report), "post" do

      assert_select "input[name=?]", "report[classroom_subject_id]"

      assert_select "input[name=?]", "report[user_id]"

      assert_select "input[name=?]", "report[actual_mark]"

      assert_select "input[name=?]", "report[total_marks]"

      assert_select "input[name=?]", "report[report_type]"
    end
  end
end
