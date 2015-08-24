module SdkHelper
  TRANSLATIONS_FILE_NAME = 'sdk.js'
  DEFAULT_LOCALE = :en

  def i18n_translations(locale)
    locale = locale.to_sym
    sdk_translations_segments = SimplesIdeias::I18n.translation_segments.select { |key, _| key.ends_with?(TRANSLATIONS_FILE_NAME) }
    locale_translations_segment = sdk_translations_segments.find { |_, value| value.has_key?(locale) }
    locale_translations_segment.try(:[], 1)
  end

  def i18n_translations_or_default(locale)
    i18n_translations(locale) || i18n_translations(DEFAULT_LOCALE)
  end
end
