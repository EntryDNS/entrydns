set :application, 'simpledns'
set :domain, 'zooz.dyndns.org'
set :repository,  "set your repository location here" # TODO: write me
# set :repository,  "ssh://#{domain}/home/clyfe/dev/#{application}.git"
set :repository,  "/home/clyfe/dev/#{application}.git"
set :use_sudo, false
set :deploy_to, '/srv/www/apps/entrydns'
set :user, 'clyfe'
set :scm, 'git'

role :web, domain                   # Your HTTP server, Apache/etc
role :app, domain                   # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end
