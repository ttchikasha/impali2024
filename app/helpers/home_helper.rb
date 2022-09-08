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

  def staff_member(initials:, position:)
    render(StaffMemberComponent.new(initials: initials, position: position, image: initials.parameterize + ".jpg"))
  end

  private

  def on_home?
    controller.controller_name == "home"
  end
end
