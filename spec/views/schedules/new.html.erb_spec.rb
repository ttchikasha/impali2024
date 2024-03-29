require 'rails_helper'

RSpec.describe "schedules/new", type: :view do
  before(:each) do
    assign(:schedule, Schedule.new(
      title: "MyString",
      calendar_id: 1,
      location: "MyString"
    ))
  end

  it "renders new schedule form" do
    render

    assert_select "form[action=?][method=?]", schedules_path, "post" do

      assert_select "input[name=?]", "schedule[title]"

      assert_select "input[name=?]", "schedule[calendar_id]"

      assert_select "input[name=?]", "schedule[location]"
    end
  end
end
