#!/bin/bash
if [[ $(whoami) != 'root' ]]; then
  echo 'Must be run with sudo.'
  exit 1
fi

if [[ $# != 1 ]]; then
  echo 'Specify rpm file to deploy'
  exit 1
fi

sudo yum update -y $1
su - entrydns -s /bin/bash -c 'bundle exec rake db:migrate RAILS_ENV=production'

systemctl reload unicorn-entrydns.service

systemctl status unicorn-entrydns.service

