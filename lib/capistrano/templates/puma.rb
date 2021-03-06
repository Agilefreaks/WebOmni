#!/usr/bin/env puma

directory '/var/www/webomni/current'
rackup '/var/www/webomni/current/config.ru'
environment ENV['RAILS_ENV']

pidfile '/var/www/webomni/shared/tmp/pids/puma.pid'
state_path '/var/www/webomni/shared/tmp/pids/puma.state'
stdout_redirect '/var/www/webomni/shared/log/puma_access.log', '/var/www/webomni/shared/log/puma_error.log', true

threads 0, 1

bind 'unix:/var/www/webomni/shared/tmp/sockets/puma.sock'
workers 2

preload_app!

on_restart do
  ENV['BUNDLE_GEMFILE'] = '/var/www/webomni/current/Gemfile'
end
