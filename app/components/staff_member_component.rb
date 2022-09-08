# frozen_string_literal: true

class StaffMemberComponent < ViewComponent::Base
  def initialize(image:, initials:, position:)
    @image = image
    @initials = initials
    @position = position
  end

end
