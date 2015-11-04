#!/usr/bin/env bash

if [ ! -f /opt/provision/useradd ]; then

  for i in {1..50}; do
    username="training${i}"

    id -u ${username} &>/dev/null || useradd -m -g users -s /bin/bash ${username}
    echo "${username}:P@ssw0rd147" | chpasswd
  done

  touch /opt/provision/useradd
fi
