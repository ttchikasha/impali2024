require 'rails_helper'

RSpec.describe "question_answers/show", type: :view do
  before(:each) do
    @question_answer = assign(:question_answer, QuestionAnswer.create!(
      question: nil,
      user: nil,
      selected_answer: "Selected Answer",
      answer: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Selected Answer/)
    expect(rendered).to match(//)
  end
end
