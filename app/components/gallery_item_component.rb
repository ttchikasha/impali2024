# frozen_string_literal: true

class GalleryItemComponent < ViewComponent::Base
  def initialize(title:, image:, category:)
    @title = title
    @image = image
    @category = category
  end
end
