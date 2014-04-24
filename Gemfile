source 'https://rubygems.org'
ruby '2.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
gem 'activeresource'

gem 'puma'

gem 'haml'
gem 'haml-rails'
gem 'less-rails'

gem 'devise'
gem 'omniauth-google-oauth2'

gem 'useragent'
gem 'phone'

gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 4.0.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtime
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 2.5.0'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'humane-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'pry-rails'

  # deploy
  gem 'capistrano', '~> 3.1', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-puma', require: false
end

group :development, :test do
  gem 'awesome_print'
  gem 'rb-inotify', '~> 0.9'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'rspec-spies'
  gem 'guard-rspec'
end

group :test do
  gem 'simplecov'
  gem 'simplecov-teamcity-summary', github: 'balauru/simplecov-teamcity-summary'
  gem 'accept_values_for'
  gem 'capybara'
  gem 'email_spec'
end
