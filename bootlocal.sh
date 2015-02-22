#!/usr/bin/env sh

# Regenerate certs for the newly created Iprivate network IP
sudo /etc/init.d/docker restart

# Copy tls certs to the vagrant share to allow host to use it
sudo cp -r /var/lib/boot2docker/tls /vagrant/