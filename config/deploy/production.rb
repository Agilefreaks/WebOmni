set :deploy_to, '/var/www/webomni'
set :branch, 'production'

set :rails_env, 'production'

role :app, %w(deploy@webproduction01.omnipasteapp.com deploy@webproduction02.omnipasteapp.com)
role :web, %w(deploy@webproduction01.omnipasteapp.com deploy@webproduction02.omnipasteapp.com)
