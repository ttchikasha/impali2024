module AccessAuthorizer
  private

  def authorize_paid_students
    unless current_user.can_access_lessons?
      redirect_to dashboard_path, alert: "Only paid students can access content"
    end
  end
end
