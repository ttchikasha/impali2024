require 'rails_helper'

RSpec.describe "reports/index", type: :view do
  before(:each) do
    assign(:reports, [
      Report.create!(
        classroom_subject: nil,
        user: nil,
        actual_mark: 2,
        total_marks: 3,
        report_type: 4
      ),
      Report.create!(
        classroom_subject: nil,
        user: nil,
        actual_mark: 2,
        total_marks: 3,
        report_type: 4
      )
    ])
  end

  it "renders a list of reports" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
  end
end
