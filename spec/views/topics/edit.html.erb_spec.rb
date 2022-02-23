require 'rails_helper'

RSpec.describe "topics/edit", type: :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
      title: "MyString",
      description: "MyText",
      classroom_subject: nil
    ))
  end

  it "renders the edit topic form" do
    render

    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do

      assert_select "input[name=?]", "topic[title]"

      assert_select "textarea[name=?]", "topic[description]"

      assert_select "input[name=?]", "topic[classroom_subject_id]"
    end
  end
end
