namespace :puma do
  desc 'Start puma'
  task :start do
    on roles(:web) do
      within release_path do
        execute :bundle, :exec, 'puma --config config/puma.rb'
      end
    end
  end

  task :stop do
    on roles(:web), in: :parallel do
      within shared_path do
        pid_file = "#{shared_path}/sockets/puma.pid"

        if test("[ -e #{pid_file} ]")
          socket_file = "#{shared_path}/sockets/puma.sock"
          state_file = "#{shared_path}/sockets/puma.state"

          execute "kill -9 `cat #{pid_file}`"
          sleep 3
          execute "rm #{pid_file}"
          execute "rm #{socket_file}"
          execute "rm #{state_file}"
        end
      end
    end
  end

  task :restart do
    invoke 'puma:stop'
    invoke 'puma:start'
  end

  after 'deploy:published', 'puma:restart'
end