set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

default_run_options[:pty] = true
set :application, 'entrydns'

set :repository,  "git@bitbucket.org:clyfe/entrydns.git"
set :deploy_to, '/srv/www/apps/entrydns'
set :user, 'clyfe'
set :use_sudo, false
set :scm, 'git'
set :ssh_options, :forward_agent => true
set :deploy_via, :remote_cache
# set :branch, "master"
# set :scm_verbose, true
# set :git_enable_submodules,
# set :scm_passphrase, "passwd0" # the deploy user's password

after 'deploy:update_code', 'deploy:symlink_database_yml'
after 'deploy:update_code', 'deploy:symlink_settings_yml'

load 'deploy/assets'

# TODO
# chown -R clyfe:wwwdata /srv/www/apps/entrydns/current/public
# find /srv/www/apps/entrydns/current/public -type d -exec chmod 0750 {} +
# find /srv/www/apps/entrydns/current/public -type f -exec chmod 0640 {} +

# TODO
# precompile assets

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Symlinks the database.yml"
  task :symlink_database_yml, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlinks the settings.yml"
  task :symlink_settings_yml, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/settings.yml #{release_path}/config/settings.yml"
  end

  desc "Populates the Production Database"
  task :seed do
    run "cd #{current_path}; #{rake} db:seed RAILS_ENV=production"
  end
end
