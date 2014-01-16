source 'https://rubygems.org'
ruby '2.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'mongoid', '4.0.0.alpha1'
gem 'bson_ext'

gem 'puma'

gem 'haml'
gem 'haml-rails'
gem 'less-rails'
gem 'cells'
gem 'simple_form'

gem 'devise'
gem 'omniauth-google-oauth2'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'

gem 'useragent'
gem 'phone'

gem 'newrelic_rpm'
gem 'newrelic-grape'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtime
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'humane-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'rails_admin'

gem 'gcm'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'pry-rails'

  # deploy
  gem 'capistrano', '~> 3.0', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-puma', require: false, github: 'balauru/capistrano-puma'
end

group :development, :test do
  gem 'awesome_print'
  gem 'rb-inotify', '~> 0.9'
  gem 'rspec-rails', '~> 2.0'
  gem 'rspec-spies'
  # use this to fetch the UI page one time
  gem 'grape-swagger-rails', github: 'balauru/grape-swagger-rails'
end

group :test do
  gem 'rspec-cells'
  gem 'database_cleaner'
  gem 'rspec-set'
  gem 'accept_values_for'
  gem 'shoulda'
  gem 'simplecov'
  gem 'capybara'
  gem 'email_spec'
  gem 'mongoid-rspec'
  gem 'fabrication'
  gem 'zeus', '0.13.4.pre2'
  gem 'guard'
  gem 'guard-zeus'
end