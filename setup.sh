#!/bin/bash

# dont let steam delete user directory
set -euo pipefail

# update
apt update
apt upgrade -y

# setup firewall
ufw allow OpenSSH
ufw --force enable

# clone all the things
mkdir /www
git clone https://github.com/Cheespeasa1234/natelevison.com.git /www/natelevison.com
git clone https://github.com/Cheespeasa1234/static.natelevison.com.git /www/static.natelevison.com

mkdir /tmp/website-infra
git clone https://github.com/Cheespeasa1234/website-infra.git /tmp/website-infra

# setup nginx
apt install nginx -y
ufw allow 'Nginx Full'

cp /tmp/website-infra/website-nginx/nginx.conf /etc/nginx/nginx.conf
cp /tmp/website-infra/website-nginx/sites-available /etc/nginx -r
rm /etc/nginx/sites-available default
cp /tmp/website-infra/website-nginx/sites-enabled /etc/nginx -r
rm /etc/nginx/sites-enabled default

# setup website
apt install nodejs -y
apt install npm -y

cd /www/natelevison.com
npm install -y
npm install node
npm run build

# setup services
cp /tmp/website-infra/website-system/*.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable website.service
systemctl restart website.service
systemctl restart nginx