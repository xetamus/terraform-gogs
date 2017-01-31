#!/bin/bash

wget -qO - https://deb.packager.io/key | sudo apt-key add -
echo "deb https://deb.packager.io/gh/pkgr/gogs xenial pkgr" | sudo tee /etc/apt/sources.list.d/gogs.list
apt-get update -y
apt-get install -y gogs
