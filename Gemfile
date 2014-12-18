source 'https://rubygems.org'
ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
gem 'mongoid'
gem 'mongo_session_store-rails4'
gem 'activeresource', :require => 'active_resource'
gem 'httparty'

gem 'puma'

gem 'devise'
gem 'omniauth-google-oauth2'

gem 'useragent'

gem 'newrelic_rpm'

gem 'haml'
gem 'haml-rails'

gem 'cells'
gem 'humane-rails', '~> 5.0.2'

gem 'coffee-script'
gem 'coffee-rails'
gem 'uglifier'
gem 'therubyracer'

gem 'less-rails'
gem 'twitter-bootstrap-rails', '~> 3.2.0'
gem 'jquery-rails'
gem 'modernizr-rails'

gem 'gravtastic'

gem 'sitemap_generator'

gem 'mobile-fu'

gem 'mixpanel-ruby'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'pry-rails'

  # deploy
  gem 'capistrano', '~> 3.2', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-puma', require: false
end

group :development, :test do
  gem 'awesome_print'
  gem 'rb-inotify', '~> 0.9'
  gem 'spring-commands-rspec'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'rspec-cells'
  gem 'guard-rspec'
  gem 'mongoid-rspec'
  gem 'rspec-activemodel-mocks'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'cucumber-rails', require: false
end

group :test do
  gem 'simplecov'
  gem 'simplecov-teamcity-summary', github: 'balauru/simplecov-teamcity-summary'
  gem 'accept_values_for'
  gem 'capybara'
  gem 'email_spec'
end
