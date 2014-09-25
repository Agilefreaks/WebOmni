module ApplicationHelper
  def localize(image_path, type = :svg)
    image_path.concat('.').concat(I18n.locale.to_s) if I18n.locale != I18n.default_locale
    image_path.concat('.').concat(type.to_s) if type
    image_path
  end
end