require 'bundler/capistrano'

set :application, 'simpledns'
set :domain, 'zooz.dyndns.org'
set :repository,  "set your repository location here" # TODO: write me
set :repository,  "ssh://#{domain}/home/clyfe/dev/#{application}.git"
set :use_sudo, false
set :deploy_to, '/srv/www/apps/entrydns'
set :user, 'clyfe'
set :scm, 'git'
set :branch, "master"
set :scm_verbose, true
#set :deploy_via, :remote_cache/:export .. etc
# set :git_enable_submodules, 1

ssh_options[:forward_agent] = true # use local keys

role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

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
end
