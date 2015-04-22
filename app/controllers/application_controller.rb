class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  has_mobile_fu false
  before_action :set_locale

  helper_method :is_mobile_device?

  def authenticate!
    authenticate_user!
  end

  def js_redirect_to(path)
    render js: %(window.location.href='#{path}')
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def set_locale
    proposed_locale = params[:locale] || extract_locale_from_accept_language_header
    I18n.locale = (proposed_locale && I18n.available_locales.include?(proposed_locale.to_sym)) ? proposed_locale : :en
  end

  private

  # noinspection RubyInstanceMethodNamingConvention
  def extract_locale_from_accept_language_header
    (request.env['HTTP_ACCEPT_LANGUAGE'] || '').scan(/^[a-z]{2}/).first
  end
end
