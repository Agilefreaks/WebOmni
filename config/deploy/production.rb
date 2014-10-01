set :deploy_to, '/var/www/webomni'
set :branch, 'production'

set :rails_env, 'production'

role :app, %w(deploy@178.62.222.61 deploy@178.62.222.15)
role :web, %w(deploy@178.62.222.61 deploy@178.62.222.15)
