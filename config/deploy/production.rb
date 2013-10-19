set :stage, :production

set :branch, 'master'

set :rails_env, :production

set :deploy_to, '/var/www/omnipaste_production'

fetch(:default_env).merge!(rails_env: :production)