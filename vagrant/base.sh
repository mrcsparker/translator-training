#!/usr/bin/env bash

mkdir -p /opt/provision

if [ ! -f /opt/provision/base ]; then

  apt-get update

  apt-get install -y libcurl4-openssl-dev
  apt-get install -y libgstreamer-plugins-base0.10-0
  apt-get install -y gdebi-core
  apt-get install -y libapparmor1
  apt-get install -y libxml2-dev
  apt-get install -y libcurl4-gnutls-dev
  apt-get install -y git

  apt-get install -y git-core
  apt-get install -y curl
  apt-get install -y zlib1g-dev
  apt-get install -y build-essential
  apt-get install -y libssl-dev
  apt-get install -y libreadline-dev
  apt-get install -y libyaml-dev
  apt-get install -y libsqlite3-dev
  apt-get install -y sqlite3
  apt-get install -y libxml2-dev
  apt-get install -y libxslt1-dev
  apt-get install -y libcurl4-openssl-dev
  apt-get install -y python-software-properties
  apt-get install -y libffi-dev
  apt-get install -y libgdbm-dev
  apt-get install -y libtool
  apt-get install -y bison

  touch /opt/provision/base
fi
