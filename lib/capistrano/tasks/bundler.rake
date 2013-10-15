namespace :bundler do
  desc 'Update the rake command to use bundle exec'
  task :use_bundle_exec do
    on roles(:all) do
      SSHKit.config.command_map[:rake] = "#{SSHKit.config.command_map[:bundle]} exec rake"
    end
  end
end

after 'rvm:init', 'bundler:use_bundle_exec'