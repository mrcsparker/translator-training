#!/usr/bin/env bash

if [ ! -f /tmp/provision.base ]; then

  apt-get update

  apt-get install -y libcurl4-openssl-dev
  apt-get install -y libgstreamer-plugins-base0.10-0
  apt-get install -y gdebi-core
  apt-get install -y libapparmor1
  apt-get install -y libxml2-dev
  apt-get install -y libcurl4-gnutls-dev
  apt-get install -y git

  touch /tmp/provision.base
fi
