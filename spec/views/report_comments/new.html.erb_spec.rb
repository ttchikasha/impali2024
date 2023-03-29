require 'rails_helper'

RSpec.describe "report_comments/new", type: :view do
  before(:each) do
    assign(:report_comment, ReportComment.new(
      co_curricular_activities: "MyString",
      neatness: 1,
      courtesy: 1,
      conduct: 1,
      deportment: 1,
      comments: "MyText",
      user: nil,
      year: 1,
      term: 1
    ))
  end

  it "renders new report_comment form" do
    render

    assert_select "form[action=?][method=?]", report_comments_path, "post" do

      assert_select "input[name=?]", "report_comment[co_curricular_activities]"

      assert_select "input[name=?]", "report_comment[neatness]"

      assert_select "input[name=?]", "report_comment[courtesy]"

      assert_select "input[name=?]", "report_comment[conduct]"

      assert_select "input[name=?]", "report_comment[deportment]"

      assert_select "textarea[name=?]", "report_comment[comments]"

      assert_select "input[name=?]", "report_comment[user_id]"

      assert_select "input[name=?]", "report_comment[year]"

      assert_select "input[name=?]", "report_comment[term]"
    end
  end
end
