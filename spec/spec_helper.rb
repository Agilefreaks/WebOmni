ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'teamcity'

require 'rubygems'

require File.expand_path('../../config/environment', __FILE__)
require 'email_spec'
require 'rspec/rails'
require 'rspec/its'

# Require all of the RSpec Support libraries
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
