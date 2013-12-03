source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'mongoid', '~> 4.0.0', github: 'mongoid/mongoid', ref: '06b708d37cdebdc50b69614e9ff84dd953993a12'
gem 'bson_ext'

gem 'puma'

gem 'haml'
gem 'haml-rails'
gem 'less-rails'
gem 'cells'
gem 'simple_form', '~> 3.0.0.rc'

gem 'devise', '~> 3.0.0.rc'
gem 'omniauth-google-oauth2'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'

gem 'useragent'
gem 'phone'

gem 'newrelic_rpm'

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
gem 'humane-rails', github: 'balauru/humane-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'rails_admin'

gem 'gcm'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'

  # deploy
  gem 'capistrano', '~> 3.0', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-puma', require: false, github: 'balauru/capistrano-puma'
end

group :production do
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

group :development, :test do
  gem 'awesome_print'
  gem 'rb-inotify', '~> 0.9'
  gem 'rspec-rails', '~> 2.0'
  gem 'rspec-spies'
end

group :test do
  gem 'rspec-cells'
  gem 'database_cleaner'
  gem 'rspec-set'
  gem 'accept_values_for'
  gem 'shoulda'
  gem 'simplecov'
  gem 'webrat'
  gem 'email_spec'
  gem 'mongoid-rspec'
  gem 'fabrication'
  gem 'zeus', '0.13.4.pre2'
  gem 'guard'
  gem 'guard-zeus'
end