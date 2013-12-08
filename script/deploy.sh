#!/bin/bash

server='master0.entrydns.net'

if [[ $# != 1 ]]; then
  echo 'Specify rpm file to deploy'
  exit 1
else:
  package=${1}
fi

scp ${package} ${server}:/tmp

ssh -t ${server} "sudo yum update -y /tmp/${package}"
ssh -t ${server} "su - entrydns -c 'cd ${HOME} && bundle exec rake db:migrate RAILS_ENV=production'
