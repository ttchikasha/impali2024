class QuestionAnswersController < ApplicationController
  before_action :set_question_answer, only: %i[ show edit update destroy ]

  # GET /question_answers or /question_answers.json
  def index
    @question_answers = QuestionAnswer.all
  end

  # GET /question_answers/1 or /question_answers/1.json
  def show
  end

  # GET /question_answers/new
  def new
    @question_answer = QuestionAnswer.new
  end

  # GET /question_answers/1/edit
  def edit
  end

  # POST /question_answers or /question_answers.json
  def create
    @question_answer = QuestionAnswer.new(question_answer_params)

    respond_to do |format|
      if @question_answer.save
        format.html { redirect_to question_answer_url(@question_answer), notice: "Question answer was successfully created." }
        format.json { render :show, status: :created, location: @question_answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_answers/1 or /question_answers/1.json
  def update
    respond_to do |format|
      if @question_answer.update(question_answer_params)
        @question_answer.assignment_answer.set_score!
        @score = @question_answer.assignment_answer.score

        format.html { redirect_to question_answer_url(@question_answer), notice: "Question answer was successfully updated." }
        format.json { render :show, status: :ok, location: @question_answer }
        format.js { }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_answers/1 or /question_answers/1.json
  def destroy
    @question_answer.destroy

    respond_to do |format|
      format.html { redirect_to question_answers_url, notice: "Question answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question_answer
    @question_answer = QuestionAnswer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_answer_params
    params.require(:question_answer).permit(:question_id, :user_id, :selected_answer, :answer, :mark)
  end
end
