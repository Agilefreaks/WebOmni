require 'simplecov'
SimpleCov.start 'rails'

require 'rubygems'

require File.expand_path('../../config/environment', __FILE__)
require 'email_spec'
require 'rspec/rails'
require 'rspec-spies'

ENV["RAILS_ENV"] = 'test' 

# Require all of the RSpec Support libraries
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }