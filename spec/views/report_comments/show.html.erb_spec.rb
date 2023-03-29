require 'rails_helper'

RSpec.describe "report_comments/show", type: :view do
  before(:each) do
    @report_comment = assign(:report_comment, ReportComment.create!(
      co_curricular_activities: "Co Curricular Activities",
      neatness: 2,
      courtesy: 3,
      conduct: 4,
      deportment: 5,
      comments: "MyText",
      user: nil,
      year: 6,
      term: 7
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Co Curricular Activities/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
  end
end
