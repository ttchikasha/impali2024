require 'rails_helper'

RSpec.describe "report_comments/index", type: :view do
  before(:each) do
    assign(:report_comments, [
      ReportComment.create!(
        co_curricular_activities: "Co Curricular Activities",
        neatness: 2,
        courtesy: 3,
        conduct: 4,
        deportment: 5,
        comments: "MyText",
        user: nil,
        year: 6,
        term: 7
      ),
      ReportComment.create!(
        co_curricular_activities: "Co Curricular Activities",
        neatness: 2,
        courtesy: 3,
        conduct: 4,
        deportment: 5,
        comments: "MyText",
        user: nil,
        year: 6,
        term: 7
      )
    ])
  end

  it "renders a list of report_comments" do
    render
    assert_select "tr>td", text: "Co Curricular Activities".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 6.to_s, count: 2
    assert_select "tr>td", text: 7.to_s, count: 2
  end
end
