class PaymentsController < ApplicationController
  before_action :verify_no_teacher
  before_action :verify_admin, only: %i[update]
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /payments or /payments.json
  def index
    base_query = current_user.admin? ? Payment : current_user.payments
    accepted = params[:accepted]
    rejected = params[:rejected]
    pending = params[:pending]
    if pending
      @payments = base_query.where(accepted: false, rejected: false)
        .paginate(page: params[:page]).order(created_at: :desc)
      @filter = "Pending"
    elsif rejected
      @payments = base_query.where(rejected: true).paginate(page: params[:page]).order(created_at: :desc)
      @filter = "Rejected"
    elsif accepted
      @payments = base_query.where(accepted: true).paginate(page: params[:page]).order(created_at: :desc)
      @filter = "Accepted"
    else
      @payments = base_query.paginate(page: params[:page]).order(created_at: :desc)
      @filter = "All"
    end
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.user = current_user

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payments_url, notice: "Payment was successfully submitted." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        flash[:notice] = "Payment was accepted successfully" if @payment.accepted
        flash[:notice] = "Payment was rejected successfully" if @payment.rejected
        format.html { redirect_to payments_url }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:term, :year, :deposit_slip, :amount, :accepted, :rejected)
  end

  def verify_admin
    unless current_user.admin?
      redirect_to dashboard_path, alert: "Only admin is authorized"
    end
  end

  def verify_no_teacher
    if current_user.teacher?
      redirect_to dashboard_path, alert: "Only students or admin are allowed"
    end
  end
end
