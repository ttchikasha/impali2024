class StudentParentsController < ApplicationController
  before_action :set_student
  before_action :verify_teacher_or_admin
  before_action :set_student_parent, only: [:edit, :update]

  def create
    @student_parent = StudentParent.new student_parent_params
    @student_parent.student = @student

    if @student_parent.save
      redirect_to @student, notice: "Student Parent Added Successfully!"
    else
      render :new
    end
  end

  def new
    @student_parent = StudentParent.new student: @student, parent: User.new
  end

  def edit
  end

  def update
    if @student_parent.update student_parent_params
      redirect_to @student, notice: "Student Parent updated successfully!"
    else
      render :edit
    end
  end

  private

  def set_student
    @student = User.students.find params[:user_id]
  end

  def set_student_parent
    @student_parent = StudentParent.includes(:student).find params[:id]
  end

  def student_parent_params
    params.require(:student_parent).permit(
      parent_attributes: [:id, :first_name, :last_name,
                          :phone, :email, :id_no, :gender],
    )
  end

  def verify_teacher_or_admin
    is_student_teacher = current_user.teacher? && @student.teacher_account == current_user

    unless is_student_teacher || current_user.admin?
      redirect_to dashboard_path, alert: "Only student teacher or admin is authorized to add parent details"
    end
  end
end
