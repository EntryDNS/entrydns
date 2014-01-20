#!/bin/bash
if [[ $(whoami) != 'root' ]]; then
  echo 'Must be run with sudo.'
  exit 1
fi

if [[ $# != 1 ]]; then
  echo 'Specify rpm file to deploy'
  exit 1
else:
  package=${1}
fi

yum update -y ${package}
su - entrydns -c 'bundle exec rake db:migrate RAILS_ENV=production'

systemctl reload unicorn-entrydns.service

systemctl status unicorn-entrydns.service
