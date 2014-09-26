set :deploy_to, '/var/www/webomni'
set :branch, 'staging'

set :rails_env, 'staging'

role :app, %w(deploy@178.62.225.139)
role :web, %w(deploy@178.62.225.139)
