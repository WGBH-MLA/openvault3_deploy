# For more options, see http://capistranorb.com/documentation/getting-started/configuration/#

# 'openvault' or 'AAPB'
set :application, ENV['APP_NAME']
set :repo_url, ENV['REPO_URL']
set :rails_env, 'production'
set :shared_path, "/var/www/#{ENV['APP_NAME']}/shared"

if ENV['BRANCH'] && ENV['BRANCH'].length > 0
  set :branch, ENV['BRANCH']
else
  ask :branch, 'master'
end

# Default value for :log_level is :debug
set :log_level, :info
# added from AAPB, not sure why this wasn't necessary for openvault
# Default value for :linked_files is []
set :passenger_environment_variables, {
  path: '/usr/local/share/gems/gems/passenger-5.3.4/bin/passenger:$PATH',
}
set :passenger_restart_with_touch, true

if ENV['APP_NAME'] == 'aapb'
  set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/ci.yml')
end

# Add the path to bundler, /home/ec2-user/bin, to $PATH env var.
set :linked_dirs, fetch(:linked_dirs, []).push('tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'tmp/downloads', 'jetty')
set :rails_env, :production
set :default_env, { 'PATH' => '$PATH:/home/ec2-user/bin' }
set :bundle_flags, '--deployment'
set :keep_releases, 1

# Require confirmation by user if the repo is in a dirty state.
include GitHelper
verify_git_status!

set :linked_dirs, fetch(:linked_dirs, []).push('log')
namespace :deploy do

  after :published, :ensure_jetty_is_installed do
    invoke 'jetty:install'
  end

  if ENV['APP_NAME'] == 'aapb'

    after :updated, :set_passenger_path do
      invoke 'deploy:config:remove_duplicate_passenger'
    end
  end
end
