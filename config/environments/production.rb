# rubocop:disable Metrics/LineLength
WebOmni::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Whether to fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'https://www.omnipasteapp.com' }
  config.action_mailer.asset_host = 'https://www.omnipasteapp.com'
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # keys
  GOOGLE_KEY = '930634995806.apps.googleusercontent.com'
  GOOGLE_SECRET = 'v9pqN_LsLoe8f0dY2i2a06lk'

  # Omniauth
  OmniAuth.config.full_host = 'https://www.omnipasteapp.com'

  # download links
  WINDOWS_CLIENT_DOWNLOAD_LINK = 'http://download.omnipasteapp.com/release/OmnipasteInstaller.msi'
  ANDROID_CLIENT_DOWNLOAD_LINK = 'https://play.google.com/store/apps/details?id=com.omnipaste.droidomni'

  # API
  OmniApi.config.base_url = 'https://api.omnipasteapp.com/api/v1'
  OmniApi.config.client_access_token = 'JJuOfwneMP6Pf6Qci0/WLhRDqh5MGQSQPo39NyscYbQ+S07bS29i9IaeT8m6ePUbkBOjqnYH1jx233rdqdL8PA=='
  OmniApi.config.client_id = '55f117236170693200000000'
  OmniApi.config.client_secret = 'mb6q0HEWkyGqDasZpf+nwElz8IgULPQ7bUuHvn1X8OIYDLlPVpxK99pcDLdeFw40V4pZA8zYJZXNKk+OFktYBw=='

  OmniKiq.configure do |config|
    config.redis_url = 'redis://10.133.201.189:6379'
  end

  config.web_omni_url = 'https://www.omnipasteapp.com'
  config.web_omni_client_id = '55f117236170693200000000'
end
