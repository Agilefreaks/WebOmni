module ApplicationHelper
  def localize(image_path, type = :svg)
    image_path.concat('.').concat(I18n.locale.to_s) if I18n.locale != I18n.default_locale
    image_path.concat('.').concat(type.to_s) if type
    image_path
  end

  def hero_title(alternative)
    alternative ? t('layout.hero.title_alternative') : t('layout.hero.title')
  end

  def hero_subtitle(alternative)
    alternative ? t('layout.hero.subtitle_alternative') : t('layout.hero.subtitle')
  end

  def download?
    params[:download]
  end
end