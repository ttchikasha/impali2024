class AssignmentsController < ApplicationController
  before_action :set_classroom_subject, only: %i[index new create]
  before_action :set_assignment, only: %i[ show edit update destroy ]
  before_action :authorize_teacher, only: %i[new create edit update destroy]

  # GET /assignments or /assignments.json
  def index
    @assignments = @classroom_subject.assignments.order(due: :desc)
  end

  # GET /assignments/1 or /assignments/1.json
  def show
    unless @assignment.can_view? current_user
      redirect_to dashboard_path, alert: "Only teacher can view assignment in draft mode"
    else
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: @assignment.name, template: "assignments/show.pdf.erb"
        end
      end
    end
  end

  # GET /assignments/new
  def new
    @assignment = @classroom_subject.assignments.new(start: Time.now)
    20.times { @assignment.questions.build }
  end

  # GET /assignments/1/edit
  def edit
    20.times { @assignment.questions.build }
  end

  # POST /assignments or /assignments.json
  def create
    @assignment = @classroom_subject.assignments.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment was successfully created." }
        format.json { render :show, status: :created, location: @assignment }
      else
        20.times { @assignment.questions.build }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to assignment_url(@assignment), notice: "Assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        20.times { @assignment.questions.build }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url, notice: "Assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def assignment_params
    params.require(:assignment).permit(:classroom_subject_id, :due, :start, questions_attributes: [:id,
                                                                                                   :text])
  end

  def authorize_teacher
    unless current_user.teacher?
      redirect_to dashboard_path, alert: "Only teacher is authorized"
    end
  end

  def set_classroom_subject
    @classroom_subject = ClassroomSubject.find params[:classroom_subject_id]

    unless current_user.admin?
      unless current_user.classroom_subjects&.include? @classroom_subject
        redirect_to dashboard_path, alert: "You cannot access other classrooms"
      end
    end
  end
end
