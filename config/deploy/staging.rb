set :stage, :staging

set :branch, 'staging'

set :rails_env, :staging

set :deploy_to, '/var/www/omnipaste_staging'

fetch(:default_env).merge!(rails_env: :staging)