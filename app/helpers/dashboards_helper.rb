module DashboardsHelper
  def on_dashboard?
    controller_path == "dashboards" && action_name == "show"
  end

  def revenue_name(val)
    if val == "Today"
      return val
    else
      return "This " + val
    end
  end
end
