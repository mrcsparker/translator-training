#!/usr/bin/env bash

if [ ! -f /opt/provision/java ]; then

  apt-get install --yes python-software-properties
  add-apt-repository ppa:webupd8team/java
  apt-get update -qq
  echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections
  apt-get install --yes oracle-java8-installer
  yes "" | apt-get -f install

  touch /opt/provision/java
fi
