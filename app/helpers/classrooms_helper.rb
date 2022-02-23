module ClassroomsHelper
  def on_classrooms_index?
    controller_path == "classrooms" && action_name == "index"
  end
end
