class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :ensure_authorized

  def index
    unless @user.student?
      redirect_to dashboard_path, alert: "Only students have results"
    end
    @reports = Report.all
    @answers = @user.assignment_answers.all.order(created_at: :desc).paginate(page: params[:page])
    @exam_results = Result.where(student_id: @user.id, for: "Exam")
    @test_results = Result.where(student_id: @user.id, for: "Test")
  end

  def new
    @result = @user.results.build
  end

  def create
    @result = @user.results.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to user_result_url(@user), notice: "Result was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def result_params
    params.require(:result).permit(:actual_mark, :classroom_subject_id, :for, :name, :term, :total_marks, :year)
  end

  def ensure_authorized
    if current_user.student? && current_user != @user
      redirect_to dashboard_path, alert: "You cannot view another student's results"
    elsif current_user.parent? && current_user.student != @user
      redirect_to dashboard_path, alert: "You can only view your child's results"
    end
  end

  def set_user
    @user = User.find params[:user_id]
  end
end
