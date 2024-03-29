class TopicsController < ApplicationController
  before_action :set_classroom_subject
  before_action :set_topic, only: %i[ show edit update destroy ]
  before_action :authorize_subject_teacher, only: %i[new create edit update destroy]

  # GET /topics or /topics.json
  def index
    @topics = @classroom_subject.topics
  end

  # GET /topics/1 or /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = @classroom_subject.topics.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = @classroom_subject.topics.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @classroom_subject, notice: "Topic was successfully created." }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @classroom_subject, notice: "Topic was successfully updated." }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to @classroom_subject, notice: "Topic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = @classroom_subject.topics.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:title, :description)
  end

  def set_classroom_subject
    @classroom_subject = ClassroomSubject.find params[:classroom_subject_id]
  end

  def authorize_subject_teacher
    unless @classroom_subject.teacher == current_user
      redirect_to dashboard_path, alert: "Only subject teacher is authorized"
    end
  end
end
