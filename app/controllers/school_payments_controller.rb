class SchoolPaymentsController < ApplicationController
  before_action :verify_admin
  before_action :set_school_payment, only: %i[ show edit update destroy ]

  # GET /school_payments or /school_payments.json
  def index
    @school_payments = SchoolPayment.all
  end

  # GET /school_payments/1 or /school_payments/1.json
  def show
  end

  # GET /school_payments/new
  def new
    @school_payment = SchoolPayment.new
  end

  # GET /school_payments/1/edit
  def edit
  end

  # POST /school_payments or /school_payments.json
  def create
    @school_payment = SchoolPayment.new(school_payment_params)

    @school_payment.year = Date.today.year
    @school_payment.term = SchoolTerm.get

    respond_to do |format|
      if @school_payment.save
        format.html { redirect_to school_payment_url(@school_payment), notice: "School payment was successfully created." }
        format.json { render :show, status: :created, location: @school_payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @school_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_payments/1 or /school_payments/1.json
  def update
    @school_payment.year = Date.today.year
    @school_payment.term = SchoolTerm.get
    respond_to do |format|
      if @school_payment.update(school_payment_params)
        format.html { redirect_to payments_path, notice: "School payment was successfully updated." }
        format.json { render :show, status: :ok, location: @school_payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_payments/1 or /school_payments/1.json
  def destroy
    @school_payment.destroy

    respond_to do |format|
      format.html { redirect_to school_payments_url, notice: "School payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_school_payment
    @school_payment = SchoolPayment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def school_payment_params
    # params.require(:school_payment).permit(:levy, :tution, :year, :term)
    params.require(:school_payment).permit(:levy, :tution)
  end

  def verify_admin
    unless current_user.admin?
      redirect_to dashboard_path, alert: "Only admin is authorized"
    end
  end
end
