require 'rails_helper'

RSpec.describe "report_comments/edit", type: :view do
  before(:each) do
    @report_comment = assign(:report_comment, ReportComment.create!(
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

  it "renders the edit report_comment form" do
    render

    assert_select "form[action=?][method=?]", report_comment_path(@report_comment), "post" do

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
