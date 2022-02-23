class StudentsController < ApplicationController
  before_action :verify_teacher

  def index
    base_query = current_user.classroom&.students.with_attached_avatar
    if params[:gender] && params[:payment_status]
      @students = base_query.where(gender: params[:gender]).select do |s|
        s.payment_status == params[:payment_status]
      end
    elsif params[:payment_status]
      @students = base_query.select do |s|
        s.payment_status == params[:payment_status]
      end
    elsif params[:gender]
      @students = base_query.where(gender: params[:gender])
    else
      @students = base_query
    end
  end

  private

  def verify_teacher
    unless current_user.teacher?
      redirect_to dashboard_path, alert: "Only teacher is authorized!"
    end
  end
end
