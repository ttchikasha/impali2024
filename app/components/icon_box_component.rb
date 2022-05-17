# frozen_string_literal: true

class IconBoxComponent < ViewComponent::Base
  def initialize(icon:, title:)
    @icon = icon
    @title = title
  end
end
