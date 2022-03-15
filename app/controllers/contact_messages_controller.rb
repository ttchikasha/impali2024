class ContactMessagesController < ApplicationController
  before_action :authenticate_user!, except: :create
  before_action :set_contact_message, only: %i[ show edit update destroy ]

  # GET /contact_messages or /contact_messages.json
  def index
    @contact_messages = ContactMessage.all.order(created_at: :desc).paginate(page: params[:page])
  end

  # GET /contact_messages/1 or /contact_messages/1.json
  def show
  end

  # GET /contact_messages/new
  def new
    @contact_message = ContactMessage.new
  end

  # GET /contact_messages/1/edit
  def edit
  end

  # POST /contact_messages or /contact_messages.json
  def create
    @contact_message = ContactMessage.new(contact_message_params)

    respond_to do |format|
      if @contact_message.save
        flash[:notice] = "Your message has been sent. Thank you!"
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @contact_message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_messages/1 or /contact_messages/1.json
  def update
    respond_to do |format|
      if @contact_message.update(contact_message_params)
        format.html { redirect_to contact_message_url(@contact_message), notice: "Contact message was successfully updated." }
        format.json { render :show, status: :ok, location: @contact_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_messages/1 or /contact_messages/1.json
  def destroy
    @contact_message.destroy

    respond_to do |format|
      format.html { redirect_to contact_messages_url, notice: "Contact message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact_message
    @contact_message = ContactMessage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :subject, :message)
  end
end
