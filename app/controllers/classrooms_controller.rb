class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[ show edit update destroy chat_room ]
  before_action :authorize_admin, only: %i[edit update destroy]
  before_action :authorize_teacher, only: %i[ index ]

  # GET /classrooms or /classrooms.json
  def index
    @classrooms = Classroom.includes(:teacher).order(:grade)
  end

  # GET /classrooms/1 or /classrooms/1.json
  def show
  end

  def chat_room
    unless current_user.classroom == @classroom
      redirect_to dashboard_path, alert: "You can only access your classroom chatroom"
    else
      @on_messages = true
      @message = @classroom.messages.build
    end
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms or /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to classroom_url(@classroom), notice: "Classroom was successfully created." }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1 or /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to classroom_url(@classroom), notice: "Classroom was successfully updated." }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1 or /classrooms/1.json
  def destroy
    @classroom.destroy

    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: "Classroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def classroom_params
    params.require(:classroom).permit(:teacher_id, :grade, :room, subject_ids: [])
  end

  def authorize_admin
    unless current_user.admin?
      redirect_to dashboard_path, alert: "Not Authorized"
    end
  end

  def authorize_teacher
    unless current_user.teacher? || current_user.admin?
      redirect_to dashboard_path, alert: "Not Authorized"
    end
  end
end
