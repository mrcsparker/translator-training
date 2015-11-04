#!/usr/bin/env bash

if [ ! -f /tmp/provision.golang ]; then

  mv /tmp/golang.sh /etc/profile.d/
  chmod +x /etc/profile.d/golang.sh

  if [ ! -f /tmp/go1.5.1.linux-amd64.tar.gz ]; then
    cd /tmp
    wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
    tar -C /opt/ -xzf go1.5.1.linux-amd64.tar.gz
  fi

  touch /tmp/provision.golang
fi
