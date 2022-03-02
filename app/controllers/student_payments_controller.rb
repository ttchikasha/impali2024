class StudentPaymentsController < ApplicationController
  before_action :authorize_admin_only
  before_action :set_student

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new payment_params
    @payment.user = @student
    @payment.accepted = true

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payments_url, notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_student
    @student = User.students.find params[:user_id]
  end

  def payment_params
    params.require(:payment).permit(:term, :year, :amount)
  end

  def authorize_admin_only
    unless current_user.admin?
      redirect_to dashboard_path, alert: "Only admin user can add payments"
    end
  end
end
