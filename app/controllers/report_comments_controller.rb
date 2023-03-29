class ReportCommentsController < ApplicationController
  before_action :set_student, only: [:new, :create, :update]
  before_action :set_report_comment, only: %i[ show edit update destroy ]

  # GET /report_comments or /report_comments.json
  def index
    @report_comments = ReportComment.all
  end

  # GET /report_comments/1 or /report_comments/1.json
  def show
  end

  # GET /report_comments/new
  def new
    @report_comment = @student.report_comments.build year: Date.today.year,
                                                     term: SchoolTerm.get
  end

  # GET /report_comments/1/edit
  def edit
  end

  # POST /report_comments or /report_comments.json
  def create
    @report_comment = @student.report_comments.new(report_comment_params)

    @report_comment.term = SchoolTerm.get
    @report_comment.year = Date.today.year

    debugger

    respond_to do |format|
      if @report_comment.save
        format.html { redirect_to report_user_results_path(@student), notice: "Report comment was successfully created." }
        format.json { render :show, status: :created, location: @report_comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_comments/1 or /report_comments/1.json
  def update
    respond_to do |format|
      if @report_comment.update(report_comment_params)
        format.html { redirect_to report_user_results_path(@student), notice: "Report comment was successfully updated." }
        format.json { render :show, status: :ok, location: @report_comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_comments/1 or /report_comments/1.json
  def destroy
    @report_comment.destroy

    respond_to do |format|
      format.html { redirect_to report_comments_url, notice: "Report comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report_comment
    @report_comment = ReportComment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_comment_params
    params.require(:report_comment).permit(:co_curricular_activities, :neatness, :courtesy, :conduct, :deportment, :comments)
  end

  def set_student
    @student = User.students.find params[:user_id]
  end
end
