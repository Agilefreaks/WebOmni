require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'rails'
require 'active_resource/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module WebOmni
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.i18n.enforce_available_locales = true

    config.generators do |g|
      g.stylesheet_engine :less
      g.view_specs false
      g.orm :mongoid
      g.template_engine :haml
    end

    config.assets.initialize_on_precompile = false
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts') << Rails.root.join('app', 'assets', 'media')
    config.assets.precompile += %w( .svg .eot .woff .ttf
                                    presentation.js presentation/presentation.css.less)

    config.paths.add 'app/api', glob: "**/*.rb"
    config.autoload_paths += Dir["#{Rails.root}/app/api/*",
                                 "#{Rails.root}/app/factories/*",
                                 "#{Rails.root}/app/interactions/*"]

    # active resource
    config.active_resource.format = :json
    config.active_resource.include_format_in_path = false
  end
end
