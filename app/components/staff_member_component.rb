# frozen_string_literal: true

class StaffMemberComponent < ViewComponent::Base
  def initialize(image:, name:, position:)
    @image = image
    @name = name
    @position = position
  end
end
