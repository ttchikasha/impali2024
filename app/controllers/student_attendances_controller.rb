class StudentAttendancesController < ApplicationController
  before_action :verify_not_student
  before_action :set_student_attendance, only: %i[ show edit update destroy ]

  # GET /student_attendances or /student_attendances.json
  def index
    base_query = current_user.admin? ? StudentAttendance.all : StudentAttendance.where(user_id: [current_user.classroom.students])
    base_query = base_query.where(user_id: params[:user_id]) if params[:user_id]
    if params[:classroom] && params[:date]
      cl = Classroom.find params[:classroom]
      result = base_query.where(user_id: [cl.students], date: params[:date])
    elsif params[:classroom]
      cl = Classroom.find params[:classroom]
      result = base_query.where(user_id: [cl.students])
    elsif params[:date]
      result = base_query.where(date: params[:date])
    else
      result = base_query
    end
    @student_attendances = result.order(date: :desc).paginate(page: params[:page])
  end

  # GET /student_attendances/1 or /student_attendances/1.json
  def show
  end

  # GET /student_attendances/new
  def new
    @student_attendance = StudentAttendance.new
  end

  # GET /student_attendances/1/edit
  def edit
  end

  # POST /student_attendances or /student_attendances.json
  def create
    @student_attendance = StudentAttendance.new(
      date: Date.today,
      user_id: params[:user_id],
      present: params[:present] || false,
    )

    respond_to do |format|
      if @student_attendance.save
        format.html { redirect_to student_attendance_url(@student_attendance), notice: "Student attendance was successfully created." }
        format.json { render :show, status: :created, location: @student_attendance }
        format.js { render :update }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student_attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_attendances/1 or /student_attendances/1.json
  def update
    respond_to do |format|
      if @student_attendance.update(student_attendance_params)
        format.html { redirect_to student_attendance_url(@student_attendance), notice: "Student attendance was successfully updated." }
        format.json { render :show, status: :ok, location: @student_attendance }
        format.js { }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student_attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_attendances/1 or /student_attendances/1.json
  def destroy
    @student_attendance.destroy

    respond_to do |format|
      format.html { redirect_to student_attendances_url, notice: "Student attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_attendance
    @student_attendance = StudentAttendance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_attendance_params
    params.permit(:present, :user_id)
  end

  def verify_not_student
    if current_user.student?
      redirect_to dashboard_path, alert: "Students are not allowed"
    end
  end
end
