#!/usr/bin/env bash

if [ ! -f /opt/provision/ruby ]; then

  su - appuser

  source $HOME/.rvm/scripts/rvm

  rvm use --default --install $1

  shift

  if (( $# )); then
    gem install $@
  fi

  rvm cleanup all

  touch /opt/provision/appuser
fi
