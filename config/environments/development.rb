# rubocop:disable Metrics/LineLength
WebOmni::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  # config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # action mailer configuration
  config.action_mailer.default_url_options = { host: 'http://localhost:3000' }
  config.action_mailer.asset_host = 'http://localhost:3000'
  config.action_mailer.delivery_method = :letter_opener

  # keys
  GOOGLE_KEY = '930634995806-f4k0a811r10uiquompfd2tfoj96f9vfn.apps.googleusercontent.com'
  GOOGLE_SECRET = 'pZ4j5qWvZYZ3rlo0cXqr8REB'

  # download links
  WINDOWS_CLIENT_DOWNLOAD_LINK = 'http://download.omnipasteapp.com/staging/OmnipasteInstaller.msi'
  ANDROID_CLIENT_DOWNLOAD_LINK = 'https://play.google.com/apps/testing/com.omnipaste.droidomni.staging'

  # API
  OmniApi.config.base_url = 'http://localhost:9292/api/v1'
  OmniApi.config.client_access_token = 'ENAh0+Xo8+oqlDzWVQP5wAEqiW4G82ptbJBR2N5ak6DACr4TRFbVslalonwMIA1Aj/tHJvWxawBD5dix+WNsww=='
  OmniApi.config.client_id = '53fefdc36170696490010000'
  OmniApi.config.client_secret = '2qNFvA4dRB3XSwrJQB2OlbjOGbWW6FSHCJUVVRG33fpMMt/DRGkq0RDoehHL87POkiJNS3tNul35p8651nhjeg=='

  OmniKiq.configure do |config|
    config.redis_url = 'redis://localhost:6379'
  end

  config.web_omni_url = 'http://localhost:3000'
  config.web_omni_client_id = '55389c0f5562751ba1000000'
end
