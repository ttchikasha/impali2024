class UsersController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :xml, :json
  before_action :set_user, only: %i[show update]
  before_action :authorize_admin, only: %i[create new edit]
  before_action :authorize_teacher_or_admin_or_parent, only: :show

  def index
    base_query = current_user.student? ? User.students : User
    base_query = base_query.with_attached_avatar
    if params[:query] && !params[:query].blank?
      base_query = User.search(params[:query])
    elsif params[:role] && params[:gender]
      base_query = User.where(role: params[:role], gender: params[:gender])
    elsif params[:role]
      base_query = User.where(role: params[:role])
    elsif params[:gender]
      base_query = User.where(gender: params[:gender])
    end

    @users = base_query.paginate(page: params[:page]).order(:created_at)
  end

  def teachers_autocomplete
    @teachers = User.teachers.search(params[:q]).paginate(page: params[:page], per_page: 15)
    render "users/teachers_autocomplete", layout: false
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "#{@user.role} successfully created!"
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:notice] = "User account updated successfully!"
      redirect_to @user
    else
      @edit = true
      render :edit
    end
  end

  def profile
    @user = current_user
    render :show
  end

  protected

  def after_update_path_for(resource)
    # sign_in_after_change_password? ? user_path(resource) : new_session_path(resource_name)
    user_path resource
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :gender, :role, :phone, :address, :city, :id_no, :start_date, :date_of_birth, :grade, :room, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin
    unless current_user.admin?
      redirect_to dashboard_path, alert: "Only admin user is authorized"
    end
  end

  def authorize_teacher_or_admin_or_parent
    is_parent = current_user.parent? && @user.parent == current_user
    unless current_user.teacher? || current_user.admin? || is_parent || current_user == @user
      redirect_to dashboard_path, alert: "Not Authorized"
    end
  end
end
