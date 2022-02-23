require 'rails_helper'

RSpec.describe "schedules/index", type: :view do
  before(:each) do
    assign(:schedules, [
      Schedule.create!(
        title: "Title",
        calendar_id: 2,
        location: "Location"
      ),
      Schedule.create!(
        title: "Title",
        calendar_id: 2,
        location: "Location"
      )
    ])
  end

  it "renders a list of schedules" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
  end
end
