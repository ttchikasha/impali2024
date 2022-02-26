class DashboardsController < ApplicationController
  def show
    if current_user.admin?
      case params[:payment]
      when "Weekly"
        data = Payment.group_by_week(:created_at)
      else
        data = Payment.group_by_month(:created_at)
      end
      @payments_data = data.sum(:amount).select { |k, v| v != 0 }
      @revenue = Payment.total_revenue params[:revenue]
    else
      @topics = current_user.recent_topics.take 5
    end
  end
end
