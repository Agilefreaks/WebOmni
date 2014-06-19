set :deploy_to, '/var/www/webomni'
set :branch, 'staging'

role :app, %w(deploy@5.10.81.82)
role :web, %w(deploy@5.10.81.82)
