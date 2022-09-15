class PardonStudentsController < ApplicationController
  def pardon
    student_id = params.fetch(:user_id)
    due_date = params.fetch(:due_date)
    student = User.students.find student_id

    if student
      student.due_date = due_date
      if student.save
        render json: { 'message': "success", due_date: student.due_date }
      else
        render json: { 'message': "error saving student", errors: student.errors }
      end
    else
      render json: { 'error': "student not found" }
    end
  end
end
