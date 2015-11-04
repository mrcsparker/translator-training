#!/usr/bin/env bash

if [ ! -f /tmp/provision.mysql ]; then

  apt-get install debconf-utils -y

  debconf-set-selections <<< "mysql-server mysql-server/root_password password P@ssw0rd2"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password P@ssw0rd2"

  apt-get install mysql-server -y

  echo "CREATE DATABASE IF NOT EXISTS movies" | mysql -u root --password=P@ssw0rd2

  touch /tmp/provision.mysql
fi
