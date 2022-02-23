class OnlineApplicationsController < ApplicationController
  before_action :authenticate_user!, except: :create
  before_action :set_online_application, only: %i[ show edit update destroy ]

  # GET /online_applications or /online_applications.json
  def index
    if state = params[:state]
      @online_applications = OnlineApplication.where(state: params[:state]).paginate(page: params[:page]).order(created_at: :desc)
    else
      @online_applications = OnlineApplication.paginate(page: params[:page]).order(created_at: :desc)
    end
  end

  # GET /online_applications/1 or /online_applications/1.json
  def show
  end

  # GET /online_applications/new
  def new
    @online_application = OnlineApplication.new
  end

  # GET /online_applications/1/edit
  def edit
  end

  # POST /online_applications or /online_applications.json
  def create
    @online_application = OnlineApplication.new(online_application_params)

    respond_to do |format|
      if @online_application.save
        flash[:info] = "We will get back to you soon via SMS and E-mail using the details you provided."
        format.html { redirect_to root_url, notice: "Your application was submitted for review" }
        format.json { render :show, status: :created, location: @online_application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @online_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /online_applications/1 or /online_applications/1.json
  def update
    respond_to do |format|
      if @online_application.update(online_application_params)
        format.html { redirect_to online_applications_url, notice: "Application was reviewed successfully." }
        format.json { render :show, status: :ok, location: @online_application }
      else
        debugger
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @online_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /online_applications/1 or /online_applications/1.json
  def destroy
    @online_application.destroy

    respond_to do |format|
      format.html { redirect_to online_applications_url, notice: "Online application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_online_application
    @online_application = OnlineApplication.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def online_application_params
    params.require(:online_application).permit(:first_name, :last_name, :phone, :email, :grade, :gender, :address, :city, :comment, :state, :files => [])
  end
end
