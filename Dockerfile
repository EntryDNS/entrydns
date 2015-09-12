FROM ubuntu:15.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get install -y \
  ruby \
  ruby-i18n \
  rake \
  nodejs \
  libxml2-dev \
  libxslt1-dev \
  bundler \
  git \
  libmysqlclient-dev \
  libsqlite3-dev \
  mysql-server

WORKDIR /entrydns
COPY Gemfile.lock /entrydns/
COPY Gemfile /entrydns/
RUN bundle install --deployment --without development test
COPY app /entrydns/app/
COPY config /entrydns/config/
COPY db /entrydns/db/
COPY lib /entrydns/lib/
COPY log /entrydns/log/
COPY public /entrydns/public/
COPY script /entrydns/script/
COPY spec /entrydns/spec/
COPY test /entrydns/test/
COPY vendor /entrydns/vendor/
COPY config.ru Rakefile /entrydns/

RUN script/compile_assets.sh
