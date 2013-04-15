require 'rubygems'
require 'spork'

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'email_spec'
  require 'rspec/rails'
  require 'rspec/autorun'

  # Require all of the RSpec Support libraries
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  RSpec.configure do |config|
    # Mock Framework
    config.mock_with :rspec

    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
  end
end

Spork.each_run do
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
end