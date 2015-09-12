#!/bin/bash

cp config/database.mysql.sample.yml config/database.yml
cp config/settings.sample.yml config/settings.yml
install -m 755 -o mysql -g root -d /var/run/mysqld
mysqld --skip-grant-tables &
sleep 3
bundle exec rake RAILS_ENV=production db:create db:schema:load
bundle exec rake RAILS_ENV=production assets:precompile
killall -9 mysqld
