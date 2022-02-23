class AssignmentAnswersController < ApplicationController
  before_action :set_assignment

  def index
    if current_user.student?
      redirect_to dashboard_path, alert: "Only teacher is authorized"
    end
    @answers = @assignment.assignment_answers.all.paginate(page: params[:page])
  end

  def create
    update_or_create
  end

  def update
    update_or_create
  end

  def show
    @answer = @assignment.assignment_answers.find params[:id]
    if !@answer
      redirect_to @assignment, alert: "Assignment Answer Not Found"
    elsif @answer.user == current_user || current_user.teacher?
      render "assignment_answers/show"
    else
      redirect_to dashboard_path, alert: "Access not authorized"
    end
  end

  private

  def set_assignment
    @assignment = Assignment.find params[:assignment_id]
  end

  def update_or_create
    params[:assignment][:questions_attributes].keys.each do |key|
      question_attribute = params[:assignment][:questions_attributes][key]
      answer = current_user.question_answers.find_or_create_by question_id: question_attribute[:id].to_i

      k = question_attribute[:question_answers_attributes]&.keys&.first
      if k
        answer_attributes = question_attribute[:question_answers_attributes][k]

        if answer_attributes[:selected_answer_id]
          answer.update_column :selected_answer_id, answer_attributes[:selected_answer_id].to_i
        else
          answer.answer = answer_attributes[:answer]
          answer.save!
        end
      end
    end
    @answer = @assignment.assignment_answers.find_or_create_by user_id: current_user.id
    redirect_to assignment_assignment_answer_path(@assignment, @answer)
  end
end
