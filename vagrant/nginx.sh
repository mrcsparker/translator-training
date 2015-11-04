#!/usr/bin/env bash

if [ ! -f /opt/provision/nginx ]; then

  apt-get -y install nginx-full

  cp /tmp/nginx.conf /etc/nginx
  cp /tmp/nginx-movies-pipeline.conf /etc/nginx/sites-enabled
  if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
  fi

  service nginx restart

  touch /opt/provision/nginx
fi
