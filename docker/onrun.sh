#!/bin/sh
# This script runs only when a MiniMeteor is used as a bundle runner, eg. for MeteorUp.
# It's ignored when executing "docker build", in that case "build.sh" is used.

# Installs build tools
apt-get -qq update
apt-get -y install curl procps python g++ make sudo git bzip2 >/dev/null

# Installs Node 4.x
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get -y install nodejs

# Unpacks whatever.tar.gz from the /bundle folder
if [ -d /bundle ]; then
  cd /bundle
  tar xzf *.tar.gz
  cd /bundle/bundle/programs/server/
  npm install --unsafe-perm
  cd /bundle/bundle/
else
  echo "You don't have a Meteor app to run in this image."
  exit 1
fi

export PORT=${PORT:-80}
node main.js

