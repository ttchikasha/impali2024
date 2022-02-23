class LessonsController < ApplicationController
  before_action :set_topic
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :authorize_teacher, only: %i[edit update destroy create new]

  # GET /lessons or /lessons.json
  def index
    @lessons = @topic.lessons.all.with_attached_banner_image
  end

  # GET /lessons/1 or /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = @topic.lessons.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = @topic.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to topic_lesson_url(@topic, @lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to topic_lesson_url(@topic, @lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to classroom_subject_topic_url(@topic.classroom_subject, @topic), notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = @topic.lessons.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lesson_params
    params.require(:lesson).permit(:content, :title, :video, :banner_image)
  end

  def set_topic
    @topic = Topic.find params[:topic_id]
  end

  def authorize_teacher
    unless current_user.teacher? && current_user.classroom_subjects.include?(@topic.classroom_subject)
      redirect_to dashboard_path, alert: "Not Authorized"
    end
  end
end
