#!/usr/bin/env bash

if [ ! -f /opt/provision/rvm ]; then
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  curl -sSL https://get.rvm.io | bash -s $1
  touch /opt/provision/rvm
fi
