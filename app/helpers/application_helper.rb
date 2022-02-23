module ApplicationHelper
  def on_subject?
    controller_path == "classroom_subjects" || (controller_path == "topics" && action_name == "new")
  end

  def on_topic?
    controller_path == "lessons" || (controller_path == "topics" && action_name != "new")
  end
end
