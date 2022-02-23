module BannerImage
  def add_banner_image
    image = RandomImage::Picker.call
    banner_image.attach io: image.io, filename: image.filename
  end

  def banner_image_path
    if banner_image.attached?
      Rails.application.routes.url_helpers.rails_representation_url(
        banner_image.variant(resize_to_limit: [500, 500]).processed, only_path: true,
      )
    end
  end
end
