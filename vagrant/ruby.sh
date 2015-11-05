#!/usr/bin/env bash

if [ ! -f /opt/provision/ruby ]; then

  rvm install 2.2.3
  rvm  --default use 2.2.3

  touch /opt/provision/ruby
fi
