set :deploy_to, '/var/www/webomni'
set :branch, 'production'

role :app, %w(deploy@5.10.81.83)
role :web, %w(deploy@5.10.81.83)
