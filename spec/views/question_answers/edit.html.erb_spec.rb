require 'rails_helper'

RSpec.describe "question_answers/edit", type: :view do
  before(:each) do
    @question_answer = assign(:question_answer, QuestionAnswer.create!(
      question: nil,
      user: nil,
      selected_answer: "MyString",
      answer: nil
    ))
  end

  it "renders the edit question_answer form" do
    render

    assert_select "form[action=?][method=?]", question_answer_path(@question_answer), "post" do

      assert_select "input[name=?]", "question_answer[question_id]"

      assert_select "input[name=?]", "question_answer[user_id]"

      assert_select "input[name=?]", "question_answer[selected_answer]"

      assert_select "input[name=?]", "question_answer[answer]"
    end
  end
end
