require 'rails_helper'

RSpec.describe "question_answers/new", type: :view do
  before(:each) do
    assign(:question_answer, QuestionAnswer.new(
      question: nil,
      user: nil,
      selected_answer: "MyString",
      answer: nil
    ))
  end

  it "renders new question_answer form" do
    render

    assert_select "form[action=?][method=?]", question_answers_path, "post" do

      assert_select "input[name=?]", "question_answer[question_id]"

      assert_select "input[name=?]", "question_answer[user_id]"

      assert_select "input[name=?]", "question_answer[selected_answer]"

      assert_select "input[name=?]", "question_answer[answer]"
    end
  end
end
