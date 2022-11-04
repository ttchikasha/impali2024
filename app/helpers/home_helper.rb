module HomeHelper
  def index_active?
    on_home? && controller.action_name == "index" ? "active" : ""
  end

  def about_active?
    on_home? && controller.action_name == "about" ? "active" : ""
  end

  def contact_active?
    on_home? && controller.action_name == "contact" ? "active" : ""
  end

  def on_profile?
    on_home? && action_name == "profile"
  end

  def staff_member(image:, name:, position:)
    render(StaffMemberComponent.new(name: name, position: position, image: image))
  end

  private

  def on_home?
    controller.controller_name == "home"
  end
end
