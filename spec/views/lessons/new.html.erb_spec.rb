require 'rails_helper'

RSpec.describe "lessons/new", type: :view do
  before(:each) do
    assign(:lesson, Lesson.new(
      topic: nil,
      title: "MyString",
      video_url: "MyString"
    ))
  end

  it "renders new lesson form" do
    render

    assert_select "form[action=?][method=?]", lessons_path, "post" do

      assert_select "input[name=?]", "lesson[topic_id]"

      assert_select "input[name=?]", "lesson[title]"

      assert_select "input[name=?]", "lesson[video_url]"
    end
  end
end
