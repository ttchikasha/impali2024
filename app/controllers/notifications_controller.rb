class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ show edit update destroy ]
  before_action :verify_admin, only: %i[new edit create update]

  # GET /notifications or /notifications.json
  def index
    base_query = case current_user.role
      when "Student"
        Notification.students_only
      when "Parent"
        Notification.parents_only
      when "Teacher"
        Notification.teachers_only
      else
        Notification
      end
    @notifications = base_query.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
    current_user.notifications << @notifications
  end

  # GET /notifications/1 or /notifications/1.json
  def show
    current_user.notifications << @notification
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications or /notifications.json
  def create
    @notification = current_user.owned_notifications.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to notification_url(@notification), notice: "Notification was successfully created." }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1 or /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to notification_url(@notification), notice: "Notification was successfully updated." }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1 or /notifications/1.json
  def destroy
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url, notice: "Notification was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
    unless @notification.user_authorized? current_user
      redirect_to notifications_path, alert: "You are not authorized to view this notice"
    end
  end

  # Only allow a list of trusted parameters through.
  def notification_params
    params.require(:notification).permit(:notifiable_id, :notifiable_type, :title, :content, :tag, :to)
  end

  def verify_admin
    unless current_user.admin?
      redirect_to dashboard_path, alert: "Not Authorized"
    end
  end
end
