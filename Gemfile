source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'mongoid', '~> 4.0.0', github: 'mongoid/mongoid'
gem 'bson_ext'

gem 'thin'

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

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
end

gem 'twitter-bootstrap-rails'
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'rails_admin'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'
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
  gem 'spork'
  gem 'spork-rails', github: 'A-gen/spork-rails'
  gem 'rspec-cells'
  gem 'guard-spork', require: 'guard'
  gem 'guard-rspec', require: 'guard'
  gem 'database_cleaner'
  gem 'rspec-set'
  gem 'accept_values_for'
  gem 'shoulda'
  gem 'simplecov'
  gem 'webrat'
  gem 'email_spec'
  gem 'mongoid-rspec'
  gem 'fabrication'
end