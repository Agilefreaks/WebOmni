module SdkHelper
  TRANSLATIONS_DIR = 'public/javascripts/i18n'
  TRANSLATIONS_FILE_NAME = 'sdk.js'
  DEFAULT_LOCALE = :en

  def i18n_translations(locale)
    begin
      File.read(Rails.root.join(TRANSLATIONS_DIR, locale.to_s).join(TRANSLATIONS_FILE_NAME))
    rescue
      nil
    end
  end

  def i18n_translations_or_default(locale)
    i18n_translations(locale) || i18n_translations(DEFAULT_LOCALE)
  end
end
