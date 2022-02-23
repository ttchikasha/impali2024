module ReportsHelper
  def on_reports_index?
    controller_path == "reports" && action_name == "index"
  end
end
