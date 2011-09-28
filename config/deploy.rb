require 'bundler/capistrano'

set :application, 'simpledns'
set :domain, 'zooz.dyndns.org'
set :repository,  "ssh://#{domain}/home/clyfe/dev/#{application}.git"
set :deploy_to, '/srv/www/apps/entrydns'
set :user, 'clyfe'
set :use_sudo, false
set :scm, 'git'
# set :branch, "master"
# set :scm_verbose, true
# set :deploy_via, :remote_cache/:export .. etc
# set :git_enable_submodules, 1

ssh_options[:forward_agent] = true # use local keys

role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

after 'deploy:update_code', 'deploy:symlink_db'

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
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end
