#!/bin/bash

APP_NAME="gogs"
MYSQL_VERSION=$(apt-cache policy mysql-server | awk '/Candidate/ {print $2}' | awk -F . '{print $1"."$2}')
MYSQL_PASSWORD="$1"
HOSTNAME="$2"

# setup mysql server and database
debconf-set-selections <<CONFIG
mysql-server mysql-server-${MYSQL_VERSION}/root_password password ${MYSQL_PASSWORD}
mysql-server mysql-server-${MYSQL_VERSION}/root_password_again password ${MYSQL_PASSWORD}
CONFIG
apt-get install -y mysql-server
mysql -uroot -p${MYSQL_PASSWORD} -e "create database if not exists ${APP_NAME};"

# setup nginx configuration
apt-get install -y nginx
cat > /etc/nginx/sites-available/default <<EOF
server {
  listen          80;
  server_name     ${HOSTNAME};
  location / {
    proxy_pass      http://localhost:3000;
  }
}
EOF
service nginx restart
