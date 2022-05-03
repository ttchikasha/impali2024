# frozen_string_literal: true

class IconBoxComponent < ViewComponent::Base
  def initialize(icon:, title:, description:)
    @icon = icon
    @title = title
    @description = description
  end
end
