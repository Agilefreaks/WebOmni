WebOmni::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_files = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.default_url_options = { host: 'http://test.com' }
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:google_oauth2,       uid: '12345',
                                                 nickname: 'calin',
                                                 info: {
                                                   first_name: 'Calin',
                                                   last_name: 'Balauru',
                                                   email: 'calin@people.com'
                                                 })

  # keys
  GOOGLE_KEY = '930634995806-f4k0a811r10uiquompfd2tfoj96f9vfn.apps.googleusercontent.com'
  GOOGLE_SECRET = 'pZ4j5qWvZYZ3rlo0cXqr8REB'

  # API
  OmniApi.config.base_url = 'https://test.omnipasteapp.com/api/v1'
  OmniApi.config.client_access_token = 'random'

  OmniKiq.configure do |c|
    c.test_mode = true
  end
end
