class ResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_result, only: %i[edit update destroy]
  before_action :ensure_authorized

  def index
    unless @user.student?
      redirect_to dashboard_path, alert: "Only students have results"
    end
    @reports = Report.all
    @answers = @user.assignment_answers.all.order(created_at: :desc).paginate(page: params[:page])
    @exam_results = Result.where(student_id: @user.id, for: "Exam").order(:classroom_subject_id)
    @test_results = Result.where(student_id: @user.id, for: "Test").order(:classroom_subject_id)
  end

  def new
    @result = @user.results.build(year: Date.today.year,
                                  term: SchoolTerm.get)
  end

  def report
  end

  def edit
  end

  def create
    @result = @user.results.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to user_results_url(@user), notice: "Result was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @result.update actual_mark: result_params[:actual_mark], remarks: result_params[:remarks]
        format.html { redirect_to user_results_url(@user), notice: "Result was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @result.destroy

    respond_to do |format|
      format.html { redirect_to user_results_url(@user), notice: "Result was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def result_params
    params.require(:result).permit(:actual_mark, :classroom_subject_id, :for, :name, :term, :total_marks, :year, :remarks)
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

  def set_result
    @result = @user.results.find params[:id]
  end
end
