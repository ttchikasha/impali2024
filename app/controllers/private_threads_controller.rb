class PrivateThreadsController < ApplicationController
  before_action :set_private_thread, only: %i[ show edit update destroy ]
  before_action :authorize_users, only: :show

  # GET /private_threads or /private_threads.json
  def index
    @private_threads = PrivateThread.all
  end

  # GET /private_threads/1 or /private_threads/1.json
  def show
    current_user.messages << @private_thread.messages
    @message = @private_thread.messages.build
  end

  # GET /private_threads/new
  def new
    @private_thread = PrivateThread.new
  end

  # GET /private_threads/1/edit
  def edit
  end

  # POST /private_threads or /private_threads.json
  def create
    thread1 = current_user.private_threads1.find_by_user2_id params[:user_id]
    @private_thread = thread1 if thread1
    thread2 = current_user.private_threads2.find_by_user1_id params[:user_id]
    @private_thread = thread2 if thread2

    unless @private_thread
      @private_thread = PrivateThread.new(user2_id: params[:user_id])
      @private_thread.user1 = current_user
    end

    respond_to do |format|
      if @private_thread.save
        format.html { redirect_to private_thread_url(@private_thread) }
        format.json { render :show, status: :created, location: @private_thread }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @private_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /private_threads/1 or /private_threads/1.json
  def update
    respond_to do |format|
      if @private_thread.update(private_thread_params)
        format.html { redirect_to private_thread_url(@private_thread), notice: "Private thread was successfully updated." }
        format.json { render :show, status: :ok, location: @private_thread }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @private_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /private_threads/1 or /private_threads/1.json
  def destroy
    @private_thread.destroy

    respond_to do |format|
      format.html { redirect_to private_threads_url, notice: "Private thread was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_private_thread
    @private_thread = PrivateThread.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def private_thread_params
    params.require(:private_thread).permit(:user2_id)
  end

  def authorize_users
    unless @private_thread.user1 == current_user || @private_thread.user2 == current_user
      redirect_to dashboard_path, alert: "Not authorized"
    end
  end
end
