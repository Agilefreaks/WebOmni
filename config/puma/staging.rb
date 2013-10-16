rails_env = 'staging'

environment rails_env

daemonize true

threads 0,16

pidfile "/var/www/omnipaste_#{rails_env}/shared/sockets/puma.pid"
state_path "/var/www/omnipaste_#{rails_env}/shared/sockets/puma.state"

stdout_redirect "/var/www/omnipaste_#{rails_env}/shared/log/puma_stdout.log", "/var/www/omnipaste_#{rails_env}/shared/log/puma_stderr.log", true

bind "unix:///var/www/omnipaste_#{rails_env}/shared/sockets/puma.sock"

activate_control_app "unix:///var/www/omnipaste_#{rails_env}/shared/sockets/pumactl.sock", { no_token: true }