#!/usr/bin/env bash

if [ ! -f /opt/provision/appuser ]; then

  id -u appuser &>/dev/null || useradd -m -g users -s /bin/bash appuser
  echo "appuser:MovieUserP@ssw0rd147" | chpasswd

  cp /tmp/bashrc-appuser /home/appuser/.bashrc
  chown appuser:users /home/appuser/.bashrc

  cp /tmp/profile-appuser /home/appuser/.profile
  chown appuser:users /home/appuser/.profile

  su - -c "mkdir -p ~/.go" appuser
  su - -c "mkdir -p ~/www" appuser
  su - -c "mkdir -p ~/bin" appuser
  su - -c "go get github.com/ant0ine/go-json-rest/rest" appuser
  su - -c "go get github.com/jinzhu/gorm" appuser
  su - -c "go get github.com/go-sql-driver/mysql" appuser

  touch /opt/provision/appuser
fi
