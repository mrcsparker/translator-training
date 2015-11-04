#!/usr/bin/env bash

if [ ! -f /opt/provision/drake ]; then

  if [ ! -f /tmp/drake ]; then
    cd /tmp
    wget https://raw.githubusercontent.com/Factual/drake/master/bin/drake
    su - -c "cp /tmp/drake ~/bin/drake" appuser
    su - -c "chmod +x ~/bin/drake" appuser
  fi

  touch /opt/provision/drake

fi
