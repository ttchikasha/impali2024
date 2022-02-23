module LessonsHelper
  def on_lessons_index?
    controller_path == "lessons" && action_name == "index"
  end
end
