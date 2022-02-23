class RandomImage::Picker < ApplicationService
  def call
    random_image
  end

  private

  BASE_PATH = "app/assets/images/random/"

  Image = Struct.new(:filepath, :name)
  ImageFile = Struct.new :io, :filename

  def random_image
    a = Dir.new(BASE_PATH).entries
    a.reject! { |s| s == ".." || s == "." }
    a.select! { |f| f.ends_with?(".jpg") || f.ends_with?(".png") }
    images = a.map { |f| Image.new(BASE_PATH + f, f) }
    result = images.sample
    ImageFile.new File.open(Rails.root.join(result.filepath)), result.name
  end
end
