require 'rails_helper'

RSpec.describe "lessons/index", type: :view do
  before(:each) do
    assign(:lessons, [
      Lesson.create!(
        topic: nil,
        title: "Title",
        video_url: "Video Url"
      ),
      Lesson.create!(
        topic: nil,
        title: "Title",
        video_url: "Video Url"
      )
    ])
  end

  it "renders a list of lessons" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Video Url".to_s, count: 2
  end
end
