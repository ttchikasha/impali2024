require 'rails_helper'

RSpec.describe "lessons/edit", type: :view do
  before(:each) do
    @lesson = assign(:lesson, Lesson.create!(
      topic: nil,
      title: "MyString",
      video_url: "MyString"
    ))
  end

  it "renders the edit lesson form" do
    render

    assert_select "form[action=?][method=?]", lesson_path(@lesson), "post" do

      assert_select "input[name=?]", "lesson[topic_id]"

      assert_select "input[name=?]", "lesson[title]"

      assert_select "input[name=?]", "lesson[video_url]"
    end
  end
end
