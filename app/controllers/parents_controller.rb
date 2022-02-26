class ParentsController < ApplicationController
  before_action :set_parent, only: %i[ show edit update destroy ]
  before_action :authorize_teacher_or_admin

  # GET /parents or /parents.json
  def index
    @parents = Parent.all
  end

  # GET /parents/1 or /parents/1.json
  def show
  end

  # GET /parents/new
  def new
    # @parent = Parent.new
    @user = User.new
    render "users/new"
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents or /parents.json
  def create
    @parent = Parent.new(parent_params)

    respond_to do |format|
      if @parent.save
        format.html { redirect_to @parent.student, notice: "Parent was successfully created." }
        format.json { render :show, status: :created, location: @parent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1 or /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to @parent.student, notice: "Parent was successfully updated." }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1 or /parents/1.json
  def destroy
    @parent.destroy

    respond_to do |format|
      format.html { redirect_to parents_url, notice: "Parent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_parent
    @parent = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def parent_params
    params.require(:parent).permit(:user_id, :first_name, :last_name, :title, :phone, :email, :occupation, :id_no)
  end

  def authorize_teacher_or_admin
    if current_user.student?
      redirect_to dashboard_path, alert: "Only teacher or admin is authorized"
    end
  end
end
