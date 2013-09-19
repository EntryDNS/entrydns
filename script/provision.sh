#!/usr/bin/env bash

# uses code from https://github.com/rinrinne/install-shared-rbenv

sudo apt-get -y update
sudo apt-get -y install python-software-properties debconf-utils
sudo apt-add-repository -y ppa:chris-lea/node.js

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password linux1'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password linux1'

sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean false'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'

sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password linux1'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password linux1'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/password-confirm password linux1'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/setup-password password linux1'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/database-type select mysql'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password linux1'

sudo debconf-set-selections <<< 'dbconfig-common dbconfig-common/mysql/app-pass password linux1'
sudo debconf-set-selections <<< 'dbconfig-common dbconfig-common/mysql/app-pass password'
sudo debconf-set-selections <<< 'dbconfig-common dbconfig-common/password-confirm password linux1'
sudo debconf-set-selections <<< 'dbconfig-common dbconfig-common/app-password-confirm password linux1'
sudo debconf-set-selections <<< 'dbconfig-common dbconfig-common/app-password-confirm password linux1'
sudo debconf-set-selections <<< 'dbconfig-common dbconfig-common/password-confirm password linux1'

sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev \
  git-core libxml2 libxml2-dev libxslt1-dev sqlite3 libsqlite3-dev curl \
  libyaml-dev openssl libssl-dev ncurses-dev libtool bison autoconf libc-dev \
  mysql-server libmysqlclient15-dev memcached nodejs apache2 phpmyadmin

set -e
CURRENT=`pwd`
RBENV_ROOT=/usr/local/rbenv
RBENV_VERSION=2.0.0-p247
mkdir -p $RBENV_ROOT
cd $RBENV_ROOT
git clone https://github.com/sstephenson/rbenv.git .
mkdir -p plugins
git clone https://github.com/sstephenson/ruby-build.git plugins/ruby-build
cd $CURRENT
export RBENV_ROOT
export RBENV_VERSION
$RBENV_ROOT/bin/rbenv install $RBENV_VERSION
$RBENV_ROOT/bin/rbenv global $RBENV_VERSION
$RBENV_ROOT/bin/rbenv exec gem install bundler
$RBENV_ROOT/bin/rbenv rehash

DOT_PROFILE=/etc/profile.d/Z99-rbenv.sh
cat > $DOT_PROFILE << EOF
RBENV_ROOT=$RBENV_ROOT
if [ -d \$RBENV_ROOT ]; then
  export RBENV_ROOT
  PATH="\$RBENV_ROOT/bin:\$PATH"
  eval "\$(rbenv init -)"
fi
EOF
sudo chmod a+x $DOT_PROFILE

cd /vagrant
$RBENV_ROOT/bin/rbenv exec bundle install --path vendor
$RBENV_ROOT/bin/rbenv exec bundle exec rake db:setup
