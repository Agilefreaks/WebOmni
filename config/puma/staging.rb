rails_env = 'staging'

threads 0,16

pidfile "/var/www/omnipaste_#{rails_env}/shared/sockets/puma.pid"
state_path "/var/www/omnipaste_#{rails_env}/shared/sockets/puma.state"

stdout_redirect "/var/www/omnipaste_#{rails_env}/shared/log/puma_stdout.log", "/var/www/omnipaste_#{rails_env}/shared/log/puma_stderr.log"

bind 'tcp://0.0.0.0:9292'

activate_control_app "unix:///var/www/omnipaste_#{rails_env}/shared/sockets/pumactl.sock", { no_token: true }