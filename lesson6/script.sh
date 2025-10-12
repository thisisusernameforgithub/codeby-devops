#!/bin/bash

set -euo pipefail

apt-get update -y > /dev/null
apt-get install -y openssh-server openssh-client > /dev/null

if [ ! -d "/home/vagrant/.ssh" ]; then
    su -c "mkdir /home/vagrant/.ssh" vagrant
    su -c "chmod 700 /home/vagrant/.ssh" vagrant
fi

# server
if [ "$(hostname)" = "server" ]; then
    echo "start"
    if [ -f /vagrant/id_rsa.pub ]; then
        su -c "cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys" vagrant
        su -c "chmod 600 /home/vagrant/.ssh/authorized_keys" vagrant
    else
        echo "error"
    fi
    echo "done"
fi

# client
if [ "$(hostname)" = "client" ]; then
    echo "start"
    if [ -f /vagrant/id_rsa ]; then
        su -c "cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa" vagrant
        su -c "chmod 600 /home/vagrant/.ssh/id_rsa" vagrant
    else
        echo "error"
    fi
    chown vagrant:vagrant /home/vagrant/.ssh/config
    chmod 600 /home/vagrant/.ssh/config
    echo "done"
fi
