set :deploy_to, '/var/www/webomni'
set :branch, 'staging'

set :rails_env, 'staging'

role :app, %w(deploy@webstaging01.omnipasteapp.com)
role :web, %w(deploy@webstaging02.omnipasteapp.com)
