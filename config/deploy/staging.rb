set :deploy_to, '/var/www/webomni'
set :branch, 'staging'

set :rails_env, 'staging'

role :app, %w(deploy@178.62.224.228)
role :web, %w(deploy@178.62.224.228)
