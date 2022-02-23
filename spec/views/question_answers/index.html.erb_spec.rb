require 'rails_helper'

RSpec.describe "question_answers/index", type: :view do
  before(:each) do
    assign(:question_answers, [
      QuestionAnswer.create!(
        question: nil,
        user: nil,
        selected_answer: "Selected Answer",
        answer: nil
      ),
      QuestionAnswer.create!(
        question: nil,
        user: nil,
        selected_answer: "Selected Answer",
        answer: nil
      )
    ])
  end

  it "renders a list of question_answers" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Selected Answer".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
