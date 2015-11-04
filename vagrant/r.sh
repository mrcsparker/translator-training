#!/usr/bin/env bash

if [ ! -f /tmp/provision.r ]; then

  mv /tmp/r.list /etc/apt/sources.list.d/r.list
  mv /tmp/Rprofile.site /etc/R/Rprofile.site

  # Secure APT
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
  apt-get update
  apt-get install -y r-base r-base-dev

  if [ ! -f /tmp/rstudio-server-0.99.467-amd64.deb ]; then
    cd /tmp
    wget http://download2.rstudio.org/rstudio-server-0.99.467-amd64.deb
    gdebi -n rstudio-server-0.99.467-amd64.deb
  fi

  touch /tmp/provision.r
fi
