rails_env = ENV['RAILS_ENV'] || 'development'

environment rails_env

daemonize true

threads 2,16

bind "unix:///var/www/omnipaste_#{rails_env}/shared/sockets/puma.sock"
pidfile "/var/www/omnipaste_#{rails_env}/shared/sockets/puma.pid"
state_path "/var/www/omnipaste_#{rails_env}/shared/sockets/puma.state"